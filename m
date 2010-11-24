From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Nov 2010 15:55:39 +0100
Subject: [PATCH 5/7 v2] at91/picotux200: remove commenting usb device and
	dataflash support
In-Reply-To: <20101124143448.GH11909@game.jcrosoft.org>
References: <20101124143448.GH11909@game.jcrosoft.org>
Message-ID: <1290610541-29255-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as based on http://www.picotux.com/pt200/picotux200.pdf
these board does not have such I/O

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-picotux200.c |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index ac1a3b5..55dad3a 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -74,11 +74,6 @@ static struct at91_usbh_data __initdata picotux200_usbh_data = {
 	.ports		= 1,
 };
 
-// static struct at91_udc_data __initdata picotux200_udc_data = {
-// 	.vbus_pin	= AT91_PIN_PD4,
-// 	.pullup_pin	= AT91_PIN_PD5,
-// };
-
 static struct at91_mmc_data __initdata picotux200_mmc_data = {
 	.det_pin	= AT91_PIN_PB27,
 	.slot_b		= 0,
@@ -86,21 +81,6 @@ static struct at91_mmc_data __initdata picotux200_mmc_data = {
 	.wp_pin		= AT91_PIN_PA17,
 };
 
-// static struct spi_board_info picotux200_spi_devices[] = {
-// 	{	/* DataFlash chip */
-// 		.modalias	= "mtd_dataflash",
-// 		.chip_select	= 0,
-// 		.max_speed_hz	= 15 * 1000 * 1000,
-// 	},
-// #ifdef CONFIG_MTD_AT91_DATAFLASH_CARD
-// 	{	/* DataFlash card */
-// 		.modalias	= "mtd_dataflash",
-// 		.chip_select	= 3,
-// 		.max_speed_hz	= 15 * 1000 * 1000,
-// 	},
-// #endif
-// };
-
 #define PICOTUX200_FLASH_BASE	AT91_CHIPSELECT_0
 #define PICOTUX200_FLASH_SIZE	SZ_4M
 
@@ -132,21 +112,11 @@ static void __init picotux200_board_init(void)
 	at91_add_device_eth(&picotux200_eth_data);
 	/* USB Host */
 	at91_add_device_usbh(&picotux200_usbh_data);
-	/* USB Device */
-	// at91_add_device_udc(&picotux200_udc_data);
-	// at91_set_multi_drive(picotux200_udc_data.pullup_pin, 1);	/* pullup_pin is connected to reset */
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
-	/* SPI */
-	// at91_add_device_spi(picotux200_spi_devices, ARRAY_SIZE(picotux200_spi_devices));
-#ifdef CONFIG_MTD_AT91_DATAFLASH_CARD
-	/* DataFlash card */
-	at91_set_gpio_output(AT91_PIN_PB22, 0);
-#else
 	/* MMC */
 	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
 	at91_add_device_mmc(0, &picotux200_mmc_data);
-#endif
 	/* NOR Flash */
 	platform_device_register(&picotux200_flash);
 }
-- 
1.7.1
