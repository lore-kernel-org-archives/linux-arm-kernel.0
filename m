From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:26 +0100
Subject: [PATCH 06/13] ARM i.MX27 pca100: remove unnecessary CONFIG_SPI_IMX
	ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-pca100.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index cccc0a0..faa4e04 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -187,7 +187,6 @@ static struct i2c_board_info pca100_i2c_devices[] = {
 	}
 };
 
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 static struct spi_eeprom at25320 = {
 	.name		= "at25320an",
 	.byte_len	= 4096,
@@ -211,7 +210,6 @@ static const struct spi_imx_master pca100_spi0_data __initconst = {
 	.chipselect	= pca100_spi_cs,
 	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
 };
-#endif
 
 static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
 {
@@ -389,13 +387,11 @@ static void __init pca100_init(void)
 
 	imx27_add_imx_i2c(1, &pca100_i2c1_data);
 
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_IN);
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
 	imx27_add_spi_imx0(&pca100_spi0_data);
-#endif
 
 	gpio_request(OTG_PHY_CS_GPIO, "usb-otg-cs");
 	gpio_direction_output(OTG_PHY_CS_GPIO, 1);
-- 
1.7.2.3
