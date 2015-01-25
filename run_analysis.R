#setting working directory where all necessary files are
setwd("UCI HAR Dataset/")

#reading the observation data
dattrain = read.table(file = "./train/X_train.txt")
dattest = read.table(file = "./test/X_test.txt")

#concatenating them into one table
dat = rbind(dattest,dattrain)

#makinng column names as feature name
features<- read.table("features.txt")
listofNames <-as.character(features[,2])
listofNames<-make.names(listofNames, unique=TRUE)
colnames(dat)<- listofNames


#subsetting only those columns that have mean or std in them
temp1<-dat[,grep("std",names(dat))]
temp2<-dat[,grep("mean",names(dat))]
temp<-cbind(temp1,temp2)


#getting the Y value , the activity performed
resulttrain <- read.table(file = "./train/Y_train.txt")
resulttest<-read.table(file = "./test/Y_test.txt")
totresult<-rbind(resulttest,resulttrain)



#the final datast contains the observations and the corresponding activity in each row
final<-cbind(temp,totresult)



#adding a col
final$UserActivity<-""

#giving proper activity names
for(i in 1:10299)
{
    
    if(final$V1[i] == 1)
        final$UserActivity[i] = "WALKING"
    if(final$V1[i] == 2)
        final$UserActivity[i] = "WALKING UPSTAIRS"
    if(final$V1[i] == 3)
        final$UserActivity[i] = "WALKING DOWNSTAIRS"
    if(final$V1[i] == 4)
        final$UserActivity[i] = "SITTING"
    if(final$V1[i] == 5)
        final$UserActivity[i] = "STANDING"
    if(final$V1[i] == 6)
        final$UserActivity[i] = "LAYING"
    
}

#removing temp variables
rm(temp2)
rm(temp)
rm(temp1)

#deleting extra column
final$V1<- NULL


#writing final dataset in a file
write.table(final,file = "final.txt",row.name = FALSE)