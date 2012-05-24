From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 24 May 2012 16:38:23 +0200
Subject: [PATCH] Drop superfluous setting of i2c_board_info.type
Message-ID: <1337870303.22505.20.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three instances of struct i2c_board_info have their "type" member set to
"tsc2007" twice. First through the I2C_BOARD_INFO macro and then
directly. Drop the superfluous second setting.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Entirely untested. I'm unsure what toolchain(s) is (are) needed to
compile this and I am certain that I don't have the hardware.

1) This is apparently legal. Doesn't gcc issue a warning for this?

 arch/arm/mach-imx/mach-cpuimx35.c     |    1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c   |    1 -
 arch/arm/mach-shmobile/board-ap4evb.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

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
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b56dde2..801de4b 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1168,7 +1168,6 @@ static struct tsc2007_platform_data tsc2007_info = {
 
 static struct i2c_board_info tsc_device = {
 	I2C_BOARD_INFO("tsc2007", 0x48),
-	.type		= "tsc2007",
 	.platform_data	= &tsc2007_info,
 	/*.irq is selected on ap4evb_init */
 };
-- 
1.7.7.6
