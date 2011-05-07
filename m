From: maxim.osipov@gmail.com (Maxim Osipov)
Date: Sat, 07 May 2011 12:47:00 +0100
Subject: [PATCH] AT91: Add external RTC for Flexibity board
Message-ID: <4DC53134.8070706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch enables external RTC support on AT91 Flexibity board.

Kind regards,
Maxim


Signed-off-by: Maxim Osipov <maxim.osipov@gmail.com>
---
 arch/arm/mach-at91/board-flexibity.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index c8a62dc..4fdc96c 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-at91/board-flexibity.c
  *
- *  Copyright (C) 2010 Flexibity
+ *  Copyright (C) 2010-2011 Flexibity
  *  Copyright (C) 2005 SAN People
  *  Copyright (C) 2006 Atmel
  *
@@ -65,6 +65,13 @@ static struct at91_udc_data __initdata flexibity_udc_data = {
 	.pullup_pin	= 0,		/* pull-up driven by UDC */
 };
 
+/* I2C devices */
+static struct i2c_board_info __initdata flexibity_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1307", 0x68),
+	},
+};
+
 /* SPI devices */
 static struct spi_board_info flexibity_spi_devices[] = {
 	{	/* DataFlash chip */
@@ -143,6 +150,9 @@ static void __init flexibity_board_init(void)
 	at91_add_device_usbh(&flexibity_usbh_data);
 	/* USB Device */
 	at91_add_device_udc(&flexibity_udc_data);
+	/* I2C */
+	at91_add_device_i2c(flexibity_i2c_devices,
+		ARRAY_SIZE(flexibity_i2c_devices));
 	/* SPI */
 	at91_add_device_spi(flexibity_spi_devices,
 		ARRAY_SIZE(flexibity_spi_devices));
-- 
1.7.4.1
