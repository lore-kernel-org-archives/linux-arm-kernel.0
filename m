From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Feb 2011 10:59:44 +0100
Subject: [PATCH] ARM: imx+mx3: convert to mc13xxx MFD
Message-ID: <1297331984-13294-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx27_3ds.c    |    6 +++---
 arch/arm/mach-imx/mach-pcm038.c      |    8 ++++----
 arch/arm/mach-mx3/mach-mx31_3ds.c    |    6 +++---
 arch/arm/mach-mx3/mach-mx31lilly.c   |    4 ++--
 arch/arm/mach-mx3/mach-mx31lite.c    |    6 +++---
 arch/arm/mach-mx3/mach-mx31moboard.c |    8 ++++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1643315..49e6a75 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -216,7 +216,7 @@ static struct regulator_init_data vgen_init = {
 	.consumer_supplies = vgen_consumers,
 };
 
-static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
+static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_VMMC1,
 		.init_data = &vmmc1_init,
@@ -227,10 +227,10 @@ static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
 };
 
 /* MC13783 */
-static struct mc13783_platform_data mc13783_pdata __initdata = {
+static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.regulators = mx27_3ds_regulators,
 	.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
-	.flags  = MC13783_USE_REGULATOR,
+	.flags  = MC13XXX_USE_REGULATOR,
 };
 
 /* SPI */
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 5056148..ca20117 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -252,7 +252,7 @@ static struct regulator_init_data cam_data = {
 	.consumer_supplies = cam_consumers,
 };
 
-static struct mc13783_regulator_init_data pcm038_regulators[] = {
+static struct mc13xxx_regulator_init_data pcm038_regulators[] = {
 	{
 		.id = MC13783_REG_VCAM,
 		.init_data = &cam_data,
@@ -262,11 +262,11 @@ static struct mc13783_regulator_init_data pcm038_regulators[] = {
 	},
 };
 
-static struct mc13783_platform_data pcm038_pmic = {
+static struct mc13xxx_platform_data pcm038_pmic = {
 	.regulators = pcm038_regulators,
 	.num_regulators = ARRAY_SIZE(pcm038_regulators),
-	.flags = MC13783_USE_ADC | MC13783_USE_REGULATOR |
-		 MC13783_USE_TOUCHSCREEN,
+	.flags = MC13XXX_USE_ADC | MC13XXX_USE_REGULATOR |
+		 MC13XXX_USE_TOUCHSCREEN,
 };
 
 static struct spi_board_info pcm038_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 0d65db8..63b314c 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -138,7 +138,7 @@ static struct regulator_init_data gpo_init = {
 	}
 };
 
-static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
+static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_PWGT1SPI, /* Power Gate for ARM core. */
 		.init_data = &pwgtx_init,
@@ -156,10 +156,10 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 };
 
 /* MC13783 */
-static struct mc13783_platform_data mc13783_pdata __initdata = {
+static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.regulators = mx31_3ds_regulators,
 	.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
-	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
+	.flags  = MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN
 };
 
 /* SPI */
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index 2c59548..6d0e6c9 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -274,8 +274,8 @@ static const struct spi_imx_master spi1_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
 
-static struct mc13783_platform_data mc13783_pdata __initdata = {
-	.flags = MC13783_USE_RTC | MC13783_USE_TOUCHSCREEN,
+static struct mc13xxx_platform_data mc13783_pdata __initdata = {
+	.flags = MC13XXX_USE_RTC | MC13XXX_USE_TOUCHSCREEN,
 };
 
 static struct spi_board_info mc13783_dev __initdata = {
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 9e64c66..864aa4f 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -111,9 +111,9 @@ static const struct spi_imx_master spi1_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
 
-static struct mc13783_platform_data mc13783_pdata __initdata = {
-	.flags  = MC13783_USE_RTC |
-		  MC13783_USE_REGULATOR,
+static struct mc13xxx_platform_data mc13783_pdata __initdata = {
+	.flags  = MC13XXX_USE_RTC |
+		  MC13XXX_USE_REGULATOR,
 };
 
 static struct spi_board_info mc13783_spi_dev __initdata = {
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 1aa8d65..8fcf991 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -214,7 +214,7 @@ static struct regulator_init_data cam_vreg_data = {
 	.consumer_supplies = cam_consumers,
 };
 
-static struct mc13783_regulator_init_data moboard_regulators[] = {
+static struct mc13xxx_regulator_init_data moboard_regulators[] = {
 	{
 		.id = MC13783_REG_VMMC1,
 		.init_data = &sdhc_vreg_data,
@@ -267,12 +267,12 @@ static struct mc13783_leds_platform_data moboard_leds = {
 	.tc2_period = MC13783_LED_PERIOD_10MS,
 };
 
-static struct mc13783_platform_data moboard_pmic = {
+static struct mc13xxx_platform_data moboard_pmic = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
 	.leds = &moboard_leds,
-	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC |
-		MC13783_USE_ADC | MC13783_USE_LED,
+	.flags = MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
+		MC13XXX_USE_ADC | MC13XXX_USE_LED,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
-- 
1.7.2.3
