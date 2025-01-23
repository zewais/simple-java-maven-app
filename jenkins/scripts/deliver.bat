@echo off
setlocal EnableDelayedExpansion

echo "The following Maven command installs your Maven-built Java application"
echo "into the local Maven repository, which will ultimately be stored in"
echo "Jenkinss local Maven repository (and the "maven-repository" Docker data"
echo "volume)."
set "-x"
mvn "jar:jar" "install:install" "help:evaluate" "-Dexpression=project.name"
set "+x"

echo "The following command extracts the value of the <name/> element"
echo "within <project/> of your Java/Maven projects "pom.xml" file."
set "-x"
SET _INTERPOLATION_0=
FOR /f "delims=" %%a in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') DO (SET "_INTERPOLATION_0=!_INTERPOLATION_0! %%a")
SET "NAME=!_INTERPOLATION_0:~1!"
set "+x"

echo "The following command behaves similarly to the previous one but"
echo "extracts the value of the <version/> element within <project/> instead."
set "-x"
SET _INTERPOLATION_1=
FOR /f "delims=" %%a in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') DO (SET "_INTERPOLATION_1=!_INTERPOLATION_1! %%a")
SET "VERSION=!_INTERPOLATION_1:~1!"
set "+x"

echo "The following command runs and outputs the execution of your Java"
echo "application (which Jenkins built using Maven) to the Jenkins UI."
set "-x"
java "-jar" "target/!NAME!-!VERSION!.jar"