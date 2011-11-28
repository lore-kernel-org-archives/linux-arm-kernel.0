From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Nov 2011 13:46:57 +0000
Subject: [PATCH] ARM: S3C64XX: Configure WM1250 EV1 GPIOs on Cragganmore
Message-ID: <1322488017-548-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 9cee041..852b15f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -37,7 +37,10 @@
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 
+#include <sound/wm1250-ev1.h>
+
 #include <asm/hardware/vic.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -625,6 +628,16 @@ static struct wm831x_pdata glenfarclas_pmic_pdata __initdata = {
 	.disable_touch = true,
 };
 
+static struct wm1250_ev1_pdata wm1250_ev1_pdata = {
+	.gpios = {
+		[WM1250_EV1_GPIO_CLK_ENA] = S3C64XX_GPN(12),
+		[WM1250_EV1_GPIO_CLK_SEL0] = S3C64XX_GPL(12),
+		[WM1250_EV1_GPIO_CLK_SEL1] = S3C64XX_GPL(13),
+		[WM1250_EV1_GPIO_OSR] = S3C64XX_GPL(14),
+		[WM1250_EV1_GPIO_MASTER] = S3C64XX_GPL(8),
+	},
+};
+
 static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("wm8311", 0x34),
 	  .irq = S3C_EINT(0),
@@ -634,7 +647,8 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x25) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x26) },
 
-	{ I2C_BOARD_INFO("wm1250-ev1", 0x27) },
+	{ I2C_BOARD_INFO("wm1250-ev1", 0x27),
+	  .platform_data = &wm1250_ev1_pdata },
 };
 
 static struct s3c2410_platform_i2c i2c1_pdata = {
-- 
1.7.7.3
