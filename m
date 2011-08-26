From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Aug 2011 20:16:45 +0100
Subject: [PATCH] ARM: S3C64XX: Hook up some additional supplies on Cragganmore
Message-ID: <1314386205-3399-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For further modules.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index db2c468..174dd0c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -292,6 +292,8 @@ static struct platform_device speyside_wm8962_device = {
 static struct regulator_consumer_supply wallvdd_consumers[] = {
 	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
+	REGULATOR_SUPPLY("SPKVDDL", "1-001a"),
+	REGULATOR_SUPPLY("SPKVDDR", "1-001a"),
 };
 
 static struct regulator_init_data wallvdd_data = {
@@ -573,6 +575,9 @@ static struct regulator_init_data pvdd_1v2 __initdata = {
 static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
 	REGULATOR_SUPPLY("PLLVDD", "1-001a"),
 	REGULATOR_SUPPLY("DBVDD", "1-001a"),
+	REGULATOR_SUPPLY("DBVDD1", "1-001a"),
+	REGULATOR_SUPPLY("DBVDD2", "1-001a"),
+	REGULATOR_SUPPLY("DBVDD3", "1-001a"),
 	REGULATOR_SUPPLY("CPVDD", "1-001a"),
 	REGULATOR_SUPPLY("AVDD2", "1-001a"),
 	REGULATOR_SUPPLY("DCVDD", "1-001a"),
-- 
1.7.5.4
