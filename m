From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Jan 2011 12:54:54 +0000
Subject: [PATCH] ARM: SMDK6410: Mark regulator setup data __initdata
Message-ID: <1295441694-16050-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the regulator API copies out the constraints we can discard
the static data once we're done booting, meaning we don't need to
carry copies of data for regulators not in the system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   38 ++++++++++++++++----------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 9fea1c2..c8a84be 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -303,14 +303,14 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 
 #ifdef CONFIG_REGULATOR
 /* ARM core */
-static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
+static __initdata struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
 	{
 		.supply = "vddarm",
 	}
 };
 
 /* VDDARM, BUCK1 on J5 */
-static struct regulator_init_data smdk6410_vddarm = {
+static __initdata struct regulator_init_data smdk6410_vddarm = {
 	.constraints = {
 		.name = "PVDD_ARM",
 		.min_uV = 1000000,
@@ -323,7 +323,7 @@ static struct regulator_init_data smdk6410_vddarm = {
 };
 
 /* VDD_INT, BUCK2 on J5 */
-static struct regulator_init_data smdk6410_vddint = {
+static __initdata struct regulator_init_data smdk6410_vddint = {
 	.constraints = {
 		.name = "PVDD_INT",
 		.min_uV = 1000000,
@@ -334,7 +334,7 @@ static struct regulator_init_data smdk6410_vddint = {
 };
 
 /* VDD_HI, LDO3 on J5 */
-static struct regulator_init_data smdk6410_vddhi = {
+static __initdata struct regulator_init_data smdk6410_vddhi = {
 	.constraints = {
 		.name = "PVDD_HI",
 		.always_on = 1,
@@ -342,7 +342,7 @@ static struct regulator_init_data smdk6410_vddhi = {
 };
 
 /* VDD_PLL, LDO2 on J5 */
-static struct regulator_init_data smdk6410_vddpll = {
+static __initdata struct regulator_init_data smdk6410_vddpll = {
 	.constraints = {
 		.name = "PVDD_PLL",
 		.always_on = 1,
@@ -350,7 +350,7 @@ static struct regulator_init_data smdk6410_vddpll = {
 };
 
 /* VDD_UH_MMC, LDO5 on J5 */
-static struct regulator_init_data smdk6410_vdduh_mmc = {
+static __initdata struct regulator_init_data smdk6410_vdduh_mmc = {
 	.constraints = {
 		.name = "PVDD_UH+PVDD_MMC",
 		.always_on = 1,
@@ -358,7 +358,7 @@ static struct regulator_init_data smdk6410_vdduh_mmc = {
 };
 
 /* VCCM3BT, LDO8 on J5 */
-static struct regulator_init_data smdk6410_vccmc3bt = {
+static __initdata struct regulator_init_data smdk6410_vccmc3bt = {
 	.constraints = {
 		.name = "PVCCM3BT",
 		.always_on = 1,
@@ -366,7 +366,7 @@ static struct regulator_init_data smdk6410_vccmc3bt = {
 };
 
 /* VCCM2MTV, LDO11 on J5 */
-static struct regulator_init_data smdk6410_vccm2mtv = {
+static __initdata struct regulator_init_data smdk6410_vccm2mtv = {
 	.constraints = {
 		.name = "PVCCM2MTV",
 		.always_on = 1,
@@ -374,7 +374,7 @@ static struct regulator_init_data smdk6410_vccm2mtv = {
 };
 
 /* VDD_LCD, LDO12 on J5 */
-static struct regulator_init_data smdk6410_vddlcd = {
+static __initdata struct regulator_init_data smdk6410_vddlcd = {
 	.constraints = {
 		.name = "PVDD_LCD",
 		.always_on = 1,
@@ -382,7 +382,7 @@ static struct regulator_init_data smdk6410_vddlcd = {
 };
 
 /* VDD_OTGI, LDO9 on J5 */
-static struct regulator_init_data smdk6410_vddotgi = {
+static __initdata struct regulator_init_data smdk6410_vddotgi = {
 	.constraints = {
 		.name = "PVDD_OTGI",
 		.always_on = 1,
@@ -390,7 +390,7 @@ static struct regulator_init_data smdk6410_vddotgi = {
 };
 
 /* VDD_OTG, LDO14 on J5 */
-static struct regulator_init_data smdk6410_vddotg = {
+static __initdata struct regulator_init_data smdk6410_vddotg = {
 	.constraints = {
 		.name = "PVDD_OTG",
 		.always_on = 1,
@@ -398,7 +398,7 @@ static struct regulator_init_data smdk6410_vddotg = {
 };
 
 /* VDD_ALIVE, LDO15 on J5 */
-static struct regulator_init_data smdk6410_vddalive = {
+static __initdata struct regulator_init_data smdk6410_vddalive = {
 	.constraints = {
 		.name = "PVDD_ALIVE",
 		.always_on = 1,
@@ -406,7 +406,7 @@ static struct regulator_init_data smdk6410_vddalive = {
 };
 
 /* VDD_AUDIO, VLDO_AUDIO on J5 */
-static struct regulator_init_data smdk6410_vddaudio = {
+static __initdata struct regulator_init_data smdk6410_vddaudio = {
 	.constraints = {
 		.name = "PVDD_AUDIO",
 		.always_on = 1,
@@ -416,7 +416,7 @@ static struct regulator_init_data smdk6410_vddaudio = {
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 /* S3C64xx internal logic & PLL */
-static struct regulator_init_data wm8350_dcdc1_data = {
+static __initdata struct regulator_init_data wm8350_dcdc1_data = {
 	.constraints = {
 		.name = "PVDD_INT+PVDD_PLL",
 		.min_uV = 1200000,
@@ -427,7 +427,7 @@ static struct regulator_init_data wm8350_dcdc1_data = {
 };
 
 /* Memory */
-static struct regulator_init_data wm8350_dcdc3_data = {
+static __initdata struct regulator_init_data wm8350_dcdc3_data = {
 	.constraints = {
 		.name = "PVDD_MEM",
 		.min_uV = 1800000,
@@ -443,7 +443,7 @@ static struct regulator_init_data wm8350_dcdc3_data = {
 };
 
 /* USB, EXT, PCM, ADC/DAC, USB, MMC */
-static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
+static __initdata struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
 	{
 		/* WM8580 */
 		.supply = "DVDD",
@@ -451,7 +451,7 @@ static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
 	},
 };
 
-static struct regulator_init_data wm8350_dcdc4_data = {
+static __initdata struct regulator_init_data wm8350_dcdc4_data = {
 	.constraints = {
 		.name = "PVDD_HI+PVDD_EXT+PVDD_SYS+PVCCM2MTV",
 		.min_uV = 3000000,
@@ -463,7 +463,7 @@ static struct regulator_init_data wm8350_dcdc4_data = {
 };
 
 /* OTGi/1190-EV1 HPVDD & AVDD */
-static struct regulator_init_data wm8350_ldo4_data = {
+static __initdata struct regulator_init_data wm8350_ldo4_data = {
 	.constraints = {
 		.name = "PVDD_OTGI+HPVDD+AVDD",
 		.min_uV = 1200000,
@@ -473,7 +473,7 @@ static struct regulator_init_data wm8350_ldo4_data = {
 	},
 };
 
-static struct {
+static __initdata struct {
 	int regulator;
 	struct regulator_init_data *initdata;
 } wm1190_regulators[] = {
-- 
1.7.2.3
