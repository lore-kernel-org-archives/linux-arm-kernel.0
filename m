From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 May 2012 22:08:07 +0200
Subject: [PATCH] ARM: imx: only specify i2c device type once
Message-ID: <1335989287-10094-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first argument of I2C_BOARD_INFO is used to assign .type, so drop
second assignment.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-cpuimx35.c   |    1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 8ecc872..b1a4796 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -70,7 +70,6 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	}, {
 		I2C_BOARD_INFO("tsc2007", 0x48),
-		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
 		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 9fbe923..89eb93c 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -124,7 +124,6 @@ static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	}, {
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
 		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
-- 
1.7.10
