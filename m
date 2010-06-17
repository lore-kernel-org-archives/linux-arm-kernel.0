From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 17 Jun 2010 20:59:03 +0200
Subject: [PATCH] eukrea_mbimx27-baseboard: fix compile when CONFIG_SPI_IMX is
	disabled
In-Reply-To: <1276801147-4103-2-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
Message-ID: <1276801147-4103-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the i2c_board_info structure landed into the SPI #if/#endif
which is wrong.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: s.hauer at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index e7fd65a..2e57912 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -301,11 +301,6 @@ static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
 	},
 };
 
-static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
 
 static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
 
@@ -315,6 +310,11 @@ static struct spi_imx_master eukrea_mbimx27_spi_0_data = {
 };
 #endif
 
+static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
 static struct platform_device *platform_devices[] __initdata = {
 	&leds_gpio,
 };
-- 
1.6.3.3
