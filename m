From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 Jan 2011 11:13:23 +0000
Subject: [PATCH] ARM: SMDK6410: Update regulator names for debugfs compatiblity
Message-ID: <1294917203-24441-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debugfs support added to the regulator API (which will be merged
in during this merge window) creates directories for regulators named
after the display names for the regulators so replace / as a separator
for multiple supplies with + in the SMDK6410 machine.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 19f9d3f..c8a84be 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -352,7 +352,7 @@ static __initdata struct regulator_init_data smdk6410_vddpll = {
 /* VDD_UH_MMC, LDO5 on J5 */
 static __initdata struct regulator_init_data smdk6410_vdduh_mmc = {
 	.constraints = {
-		.name = "PVDD_UH/PVDD_MMC",
+		.name = "PVDD_UH+PVDD_MMC",
 		.always_on = 1,
 	},
 };
@@ -418,7 +418,7 @@ static __initdata struct regulator_init_data smdk6410_vddaudio = {
 /* S3C64xx internal logic & PLL */
 static __initdata struct regulator_init_data wm8350_dcdc1_data = {
 	.constraints = {
-		.name = "PVDD_INT/PVDD_PLL",
+		.name = "PVDD_INT+PVDD_PLL",
 		.min_uV = 1200000,
 		.max_uV = 1200000,
 		.always_on = 1,
@@ -453,7 +453,7 @@ static __initdata struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
 
 static __initdata struct regulator_init_data wm8350_dcdc4_data = {
 	.constraints = {
-		.name = "PVDD_HI/PVDD_EXT/PVDD_SYS/PVCCM2MTV",
+		.name = "PVDD_HI+PVDD_EXT+PVDD_SYS+PVCCM2MTV",
 		.min_uV = 3000000,
 		.max_uV = 3000000,
 		.always_on = 1,
@@ -465,7 +465,7 @@ static __initdata struct regulator_init_data wm8350_dcdc4_data = {
 /* OTGi/1190-EV1 HPVDD & AVDD */
 static __initdata struct regulator_init_data wm8350_ldo4_data = {
 	.constraints = {
-		.name = "PVDD_OTGI/HPVDD/AVDD",
+		.name = "PVDD_OTGI+HPVDD+AVDD",
 		.min_uV = 1200000,
 		.max_uV = 1200000,
 		.apply_uV = 1,
@@ -556,7 +556,7 @@ static struct wm831x_backlight_pdata wm1192_backlight_pdata = {
 
 static struct regulator_init_data wm1192_dcdc3 = {
 	.constraints = {
-		.name = "PVDD_MEM/PVDD_GPS",
+		.name = "PVDD_MEM+PVDD_GPS",
 		.always_on = 1,
 	},
 };
@@ -567,7 +567,7 @@ static struct regulator_consumer_supply wm1192_ldo1_consumers[] = {
 
 static struct regulator_init_data wm1192_ldo1 = {
 	.constraints = {
-		.name = "PVDD_LCD/PVDD_EXT",
+		.name = "PVDD_LCD+PVDD_EXT",
 		.always_on = 1,
 	},
 	.consumer_supplies = wm1192_ldo1_consumers,
-- 
1.7.2.3
