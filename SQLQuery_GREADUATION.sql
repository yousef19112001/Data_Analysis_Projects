CREATE DATABASE HEALTH_TECH

SELECT * 
	FROM HEALTH_TECH

-- Step 1: Add the new column
ALTER TABLE HEALTH_TECH
ADD AGE_LEVELS NVARCHAR(255) ;

-- Step 2: Calculate and update the new column
UPDATE HEALTH_TECH
SET AGE_LEVELS = 
	CASE 
		WHEN AGE BETWEEN 18 AND 25 THEN 'YOUNG'
		WHEN AGE BETWEEN 26 AND 35 THEN 'ADULT'
		WHEN AGE BETWEEN 36 AND 50 THEN 'MATURE'
		ELSE 'MIDLIFE'
		END 

ALTER TABLE HEALTH_TECH
	DROP COLUMN Support_Systems_Access

ALTER TABLE HEALTH_TECH
	DROP COLUMN Online_Support_Usage
------------------------------------------------------------------------------------------------
/*GRADUATION PROJECT NOTES ABOUT HEALTH TECH*/
------------------------------------------------
--1. Calculate the average Technology_Usage_Hours by age group (e.g., 18-25, 26-35, etc.)

SELECT MAX(AGE) MAX_AGE --65 YRS
	FROM HEALTH_TECH

SELECT MIN(AGE) MAX_AGE --18 YRS
	FROM HEALTH_TECH

ALTER TABLE HEALTH_TECH
	ADD AGE_LEVELS NVARCHAR(255) ;

UPDATE HEALTH_TECH
SET AGE_LEVELS = 
	CASE 
		WHEN AGE BETWEEN 18 AND 25 THEN 'YOUNG'
		WHEN AGE BETWEEN 26 AND 35 THEN 'ADULT'
		WHEN AGE BETWEEN 36 AND 50 THEN 'MATURE'
		ELSE 'MIDLIFE'
		END 

SELECT AGE_LEVELS, 
COUNT(AGE) AS NUM_OF_EVERY_AGE_GROUP ,
ROUND(AVG(Technology_Usage_Hours),1) AS TECH_USAGE_HOURS
	FROM HEALTH_TECH 
			GROUP BY AGE_LEVELS
			ORDER BY TECH_USAGE_HOURS DESC

--2. Analyze the relationship between Social_Media_Usage_Hours and Mental_Health_Status
SELECT MAX(ROUND(Social_Media_Usage_Hours,1)) --8 HOURS
	FROM HEALTH_TECH

SELECT MIN(ROUND(Social_Media_Usage_Hours,2)) --0 HOURS
	FROM HEALTH_TECH

ALTER TABLE HEALTH_TECH
DROP COLUMN Mental_Health_Status

ALTER TABLE HEALTH_TECH
ADD  MENTAL_HEALTH_STATUS NVARCHAR(255);

UPDATE HEALTH_TECH
SET MENTAL_HEALTH_STATUS = 
	CASE 
		WHEN Social_Media_Usage_Hours BETWEEN 0 AND 1 THEN 'EXCELLENT'
		WHEN Social_Media_Usage_Hours BETWEEN 2 AND 3 THEN 'GOOD'
		WHEN Social_Media_Usage_Hours BETWEEN 4 AND 5 THEN 'FAIR'
		ELSE 'POOR'
		END 
	
SELECT 
    MENTAL_HEALTH_STATUS, 
    COUNT(MENTAL_HEALTH_STATUS) AS Count,
    ROUND(AVG(Social_Media_Usage_Hours),2) AS Average_Social_Media_Hours
FROM 
    HEALTH_TECH
GROUP BY 
    MENTAL_HEALTH_STATUS;


--3. Calculate the average Sleep_Hours for each Stress_Level category.

SELECT  
	Stress_Level, COUNT(Stress_Level) COUNT, ROUND(AVG(Sleep_Hours),2) AS AVG_SLEEP_HOURS
FROM 
	HEALTH_TECH
GROUP BY 
	Stress_Level 
ORDER BY 
	AVG_SLEEP_HOURS DESC

--4. Find the correlation between Technology_Usage_Hours and Physical_Activity_Hours

SELECT
	MAX(Physical_Activity_Hours) --10 HOURS
FROM 
	HEALTH_TECH

SELECT
	MIN(Physical_Activity_Hours) --0 HOURS
FROM 
	HEALTH_TECH

UPDATE HEALTH_TECH
SET Physical_Activity_Hours = 1
WHERE Physical_Activity_Hours = 0

ALTER TABLE HEALTH_TECH
ADD Physical_Activity_Levels NVARCHAR(255);

UPDATE HEALTH_TECH
SET Physical_Activity_Levels = 
	CASE 
		WHEN  Physical_Activity_Hours BETWEEN 1 AND 3 THEN 'LOW AVTIVE'
		WHEN  Physical_Activity_Hours BETWEEN 4 AND 7 THEN 'MODERATE ACTIVE'
		ELSE 'VERY ACTIVE'
		END

SELECT 
	 Physical_Activity_Levels, COUNT( Physical_Activity_Levels) COUNT,
	 ROUND(AVG(Technology_Usage_Hours),2) AS Technology_Usage_Hours
FROM 
	HEALTH_TECH
GROUP BY 
	 Physical_Activity_Levels

--5. Analyze the relationship between Screen_Time_Hours and Sleep_Hours


SELECT MAX(Sleep_Hours) FROM HEALTH_TECH                 -- 9 HOURS
SELECT MIN(Sleep_Hours) FROM HEALTH_TECH                 -- 4 HOURS

SELECT  
    ROUND(AVG(Screen_Time_Hours), 2) AS Average_Screen_Time,
    CASE    
        WHEN Sleep_Hours = 4 THEN 'LOW'
        WHEN Sleep_Hours = 6 THEN 'NORMAL'
        ELSE 'GOOD'
    END AS Sleep_Levels
FROM 
    HEALTH_TECHc
GROUP BY 
    CASE    
        WHEN Sleep_Hours = 4 THEN 'LOW'
        WHEN Sleep_Hours = 6 THEN 'NORMAL'
        ELSE 'GOOD'
    END

--6. Find the average Gaming_Hours for each Stress_Level

SELECT 
	Stress_Level,
	ROUND(AVG(Gaming_Hours),2) AVG_GAMING_HOURS,
	COUNT(Stress_Level) AS COUNT
FROM 
	HEALTH_TECH
GROUP BY 
	Stress_Level

--7. Calculate the average Physical_Activity_Hours for males and females

ALTER TABLE HEALTH_TECH
DROP COLUMN GENDER

ALTER TABLE HEALTH_TECH 
ADD GENDER NVARCHAR(255);

UPDATE HEALTH_TECH
SET GENDER = 
CASE
	WHEN Age BETWEEN 18 AND 40 THEN 'MALE'
	ELSE 'FEMALE'
	END

SELECT 
	ROUND(AVG(Physical_Activity_Hours),2) AS Physical_Activity_Hours,
	Gender
FROM 
	HEALTH_TECH
WHERE GENDER IN ('MALE','FEMALE')
GROUP BY Gender

--8. Calculate the average Sleep_Hours based on Work_Environment_Impact.


SELECT 
	Work_Environment_Impact,
	ROUND(AVG(Sleep_Hours),2) AVG_SLEEP_HOURS
FROM 
	HEALTH_TECH
GROUP BY 
	Work_Environment_Impact
	
--9. Calculate the correlation between Technology_Usage_Hours and Gaming_Hours.

SELECT 
	GENDER,
	ROUND(AVG(Technology_Usage_Hours),2) AS AVG_Technology_Usage_Hours,
	ROUND(AVG(Gaming_Hours),2) AS AVG_Gaming_Hours
FROM 
	HEALTH_TECH
GROUP BY 
	GENDER

--10. Analyze the average mental health status based on key factors:

--Technology_Usage_Hours
--Social_Media_Usage_Hours
--Sleep_Hours
--Physical_Activity_Hours

SELECT 
	ROUND(AVG(Technology_Usage_Hours),2) AS Technology_Usage_Hours,
	MENTAL_HEALTH_STATUS
FROM 
	HEALTH_TECH
GROUP BY 
	MENTAL_HEALTH_STATUS


SELECT 
	ROUND(AVG(Social_Media_Usage_Hours),2) AS AVG_SOCIAL_MEDIA_Usage_Hours,
	MENTAL_HEALTH_STATUS
FROM 
	HEALTH_TECH
GROUP BY 
	MENTAL_HEALTH_STATUS


SELECT 
	ROUND(AVG(Sleep_Hours),2) AS AVG_SLEEP_HOURS,
	MENTAL_HEALTH_STATUS
FROM 
	HEALTH_TECH
GROUP BY 
	MENTAL_HEALTH_STATUS


SELECT 
	ROUND(AVG(Physical_Activity_Hours),2) AS AVG_Physical_Activity_Hours,
	MENTAL_HEALTH_STATUS
FROM 
	HEALTH_TECH
GROUP BY 
	MENTAL_HEALTH_STATUS


--STRESS LEVEL BY GANDER 

SELECT COUNT(Stress_Level) COUNT, GENDER 
	FROM HEALTH_TECH
	WHERE Stress_Level IN ('HIGH','LOW')
	GROUP BY GENDER

SELECT MAX(Screen_Time_Hours) 
	FROM HEALTH_TECH

ALTER TABLE HEALTH_TECH
ADD SCREEN_TIME_LEVELS NVARCHAR(255)

UPDATE HEALTH_TECH
SET SCREEN_TIME_LEVELS = 
	CASE	
		WHEN Screen_Time_Hours BETWEEN 1 AND 5 THEN 'GOOD'
		WHEN Screen_Time_Hours BETWEEN 5 AND 10 THEN 'HIGH'
		ELSE 'EXTREME'
		END;

SELECT COUNT(SCREEN_TIME_LEVELS) SCREEN_TIME_LEVELS,
	SCREEN_TIME_LEVELS, MENTAL_HEALTH_STATUS
	FROM HEALTH_TECH
	GROUP BY SCREEN_TIME_LEVELS, MENTAL_HEALTH_STATUS