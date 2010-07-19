From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Mon, 19 Jul 2010 09:45:17 +0200
Subject: [PATCH v2] eukrea_mbimx27-baseboard: fix compile when CONFIG_SPI_IMX
	is disabled
Message-ID: <1279525517-4093-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the i2c_board_info structure landed into the SPI #if/#endif
which is wrong.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : rebased against today's imx-for-2.6.36 branch

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 27e7226..4edc5f4 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -289,12 +289,6 @@ static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
 	},
 };
 
-static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
-
 static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
 
 static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
@@ -303,6 +297,12 @@ static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
 };
 #endif
 
+static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
 static struct platform_device *platform_devices[] __initdata = {
 	&leds_gpio,
 };
-- 
1.6.3.3
