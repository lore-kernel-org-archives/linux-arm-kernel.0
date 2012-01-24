From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 21:04:55 +0000
Subject: [PATCH] ARM: S3C64XX: Fix mismerge of Littemill device in Cragganmore
Message-ID: <1327439095-28151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The -next s3c64xx tree appears to have acquired a duplicate copy of
the commit adding Littlemill which is already in mainline causing two
copies of the device definition to be in the code. Either the duplicate
should be dropped or this commit should be applied on top of it to remove
one of the duplicates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index fe7f3be..d5a7982 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -299,11 +299,6 @@ static struct platform_device littlemill_device = {
 	.id		= -1,
 };
 
-static struct platform_device littlemill_device = {
-	.name		= "littlemill",
-	.id		= -1,
-};
-
 static struct regulator_consumer_supply wallvdd_consumers[] = {
 	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
-- 
1.7.9.rc1
