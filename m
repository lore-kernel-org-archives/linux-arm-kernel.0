From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 21 Jan 2011 18:01:45 +0000
Subject: [PATCH] ARM: SMDK6410: Mark regulator setup data __initdata
Message-ID: <1295632905-23376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the regulator API copies out the constraints we can discard
the static data once we're done booting, meaning we don't need to
carry copies of data for regulators not in the system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   40 ++++++++++++++++----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index df9b76b..2f30c79 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -224,7 +224,7 @@ static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] = {
 	},
 };
 
-static struct regulator_init_data smdk6410_b_pwr_5v_data = {
+static struct regulator_init_data smdk6410_b_pwr_5v_data __initdata = {
 	.constraints = {
 		.always_on = 1,
 	},
@@ -304,14 +304,14 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 
 #ifdef CONFIG_REGULATOR
 /* ARM core */
-static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
+static struct regulator_consumer_supply smdk6410_vddarm_consumers[] __initdata  = {
 	{
 		.supply = "vddarm",
 	}
 };
 
 /* VDDARM, BUCK1 on J5 */
-static struct regulator_init_data smdk6410_vddarm = {
+static struct regulator_init_data smdk6410_vddarm __initdata = {
 	.constraints = {
 		.name = "PVDD_ARM",
 		.min_uV = 1000000,
@@ -324,7 +324,7 @@ static struct regulator_init_data smdk6410_vddarm = {
 };
 
 /* VDD_INT, BUCK2 on J5 */
-static struct regulator_init_data smdk6410_vddint = {
+static struct regulator_init_data smdk6410_vddint __initdata = {
 	.constraints = {
 		.name = "PVDD_INT",
 		.min_uV = 1000000,
@@ -335,7 +335,7 @@ static struct regulator_init_data smdk6410_vddint = {
 };
 
 /* VDD_HI, LDO3 on J5 */
-static struct regulator_init_data smdk6410_vddhi = {
+static struct regulator_init_data smdk6410_vddhi __initdata = {
 	.constraints = {
 		.name = "PVDD_HI",
 		.always_on = 1,
@@ -343,7 +343,7 @@ static struct regulator_init_data smdk6410_vddhi = {
 };
 
 /* VDD_PLL, LDO2 on J5 */
-static struct regulator_init_data smdk6410_vddpll = {
+static struct regulator_init_data smdk6410_vddpll __initdata = {
 	.constraints = {
 		.name = "PVDD_PLL",
 		.always_on = 1,
@@ -351,7 +351,7 @@ static struct regulator_init_data smdk6410_vddpll = {
 };
 
 /* VDD_UH_MMC, LDO5 on J5 */
-static struct regulator_init_data smdk6410_vdduh_mmc = {
+static struct regulator_init_data smdk6410_vdduh_mmc __initdata = {
 	.constraints = {
 		.name = "PVDD_UH+PVDD_MMC",
 		.always_on = 1,
@@ -359,7 +359,7 @@ static struct regulator_init_data smdk6410_vdduh_mmc = {
 };
 
 /* VCCM3BT, LDO8 on J5 */
-static struct regulator_init_data smdk6410_vccmc3bt = {
+static struct regulator_init_data smdk6410_vccmc3bt __initdata = {
 	.constraints = {
 		.name = "PVCCM3BT",
 		.always_on = 1,
@@ -367,7 +367,7 @@ static struct regulator_init_data smdk6410_vccmc3bt = {
 };
 
 /* VCCM2MTV, LDO11 on J5 */
-static struct regulator_init_data smdk6410_vccm2mtv = {
+static struct regulator_init_data smdk6410_vccm2mtv __initdata = {
 	.constraints = {
 		.name = "PVCCM2MTV",
 		.always_on = 1,
@@ -375,7 +375,7 @@ static struct regulator_init_data smdk6410_vccm2mtv = {
 };
 
 /* VDD_LCD, LDO12 on J5 */
-static struct regulator_init_data smdk6410_vddlcd = {
+static struct regulator_init_data smdk6410_vddlcd __initdata = {
 	.constraints = {
 		.name = "PVDD_LCD",
 		.always_on = 1,
@@ -383,7 +383,7 @@ static struct regulator_init_data smdk6410_vddlcd = {
 };
 
 /* VDD_OTGI, LDO9 on J5 */
-static struct regulator_init_data smdk6410_vddotgi = {
+static struct regulator_init_data smdk6410_vddotgi __initdata = {
 	.constraints = {
 		.name = "PVDD_OTGI",
 		.always_on = 1,
@@ -391,7 +391,7 @@ static struct regulator_init_data smdk6410_vddotgi = {
 };
 
 /* VDD_OTG, LDO14 on J5 */
-static struct regulator_init_data smdk6410_vddotg = {
+static struct regulator_init_data smdk6410_vddotg __initdata = {
 	.constraints = {
 		.name = "PVDD_OTG",
 		.always_on = 1,
@@ -399,7 +399,7 @@ static struct regulator_init_data smdk6410_vddotg = {
 };
 
 /* VDD_ALIVE, LDO15 on J5 */
-static struct regulator_init_data smdk6410_vddalive = {
+static struct regulator_init_data smdk6410_vddalive __initdata = {
 	.constraints = {
 		.name = "PVDD_ALIVE",
 		.always_on = 1,
@@ -407,7 +407,7 @@ static struct regulator_init_data smdk6410_vddalive = {
 };
 
 /* VDD_AUDIO, VLDO_AUDIO on J5 */
-static struct regulator_init_data smdk6410_vddaudio = {
+static struct regulator_init_data smdk6410_vddaudio __initdata = {
 	.constraints = {
 		.name = "PVDD_AUDIO",
 		.always_on = 1,
@@ -417,7 +417,7 @@ static struct regulator_init_data smdk6410_vddaudio = {
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 /* S3C64xx internal logic & PLL */
-static struct regulator_init_data wm8350_dcdc1_data = {
+static struct regulator_init_data wm8350_dcdc1_data __initdata = {
 	.constraints = {
 		.name = "PVDD_INT+PVDD_PLL",
 		.min_uV = 1200000,
@@ -428,7 +428,7 @@ static struct regulator_init_data wm8350_dcdc1_data = {
 };
 
 /* Memory */
-static struct regulator_init_data wm8350_dcdc3_data = {
+static struct regulator_init_data wm8350_dcdc3_data __initdata = {
 	.constraints = {
 		.name = "PVDD_MEM",
 		.min_uV = 1800000,
@@ -444,7 +444,7 @@ static struct regulator_init_data wm8350_dcdc3_data = {
 };
 
 /* USB, EXT, PCM, ADC/DAC, USB, MMC */
-static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
+static struct regulator_consumer_supply wm8350_dcdc4_consumers[] __initdata = {
 	{
 		/* WM8580 */
 		.supply = "DVDD",
@@ -452,7 +452,7 @@ static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
 	},
 };
 
-static struct regulator_init_data wm8350_dcdc4_data = {
+static struct regulator_init_data wm8350_dcdc4_data __initdata = {
 	.constraints = {
 		.name = "PVDD_HI+PVDD_EXT+PVDD_SYS+PVCCM2MTV",
 		.min_uV = 3000000,
@@ -464,7 +464,7 @@ static struct regulator_init_data wm8350_dcdc4_data = {
 };
 
 /* OTGi/1190-EV1 HPVDD & AVDD */
-static struct regulator_init_data wm8350_ldo4_data = {
+static struct regulator_init_data wm8350_ldo4_data __initdata = {
 	.constraints = {
 		.name = "PVDD_OTGI+HPVDD+AVDD",
 		.min_uV = 1200000,
@@ -477,7 +477,7 @@ static struct regulator_init_data wm8350_ldo4_data = {
 static struct {
 	int regulator;
 	struct regulator_init_data *initdata;
-} wm1190_regulators[] = {
+} wm1190_regulators[] __initdata = {
 	{ WM8350_DCDC_1, &wm8350_dcdc1_data },
 	{ WM8350_DCDC_3, &wm8350_dcdc3_data },
 	{ WM8350_DCDC_4, &wm8350_dcdc4_data },
-- 
1.7.2.3
