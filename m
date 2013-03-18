From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:24 +0900
Subject: [PATCH 028/142] ARM: shmobile: mackerel: Replace GPIO_PORTx enum with
 GPIO port numbers
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-29-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC GPIO API implementation moved to using port numbers. Replace all
GPIO_PORTx enum usage with the corresponding port number. The GPIO_PORTx
enum values are identical to the port number on this platform.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index db968a5..172d472 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -363,7 +363,7 @@ static struct fb_videomode mackerel_lcdc_modes[] = {
 
 static int mackerel_set_brightness(int brightness)
 {
-	gpio_set_value(GPIO_PORT31, brightness);
+	gpio_set_value(31, brightness);
 
 	return 0;
 }
@@ -819,22 +819,22 @@ static struct platform_device usbhs1_device = {
 static struct gpio_led mackerel_leds[] = {
 	{
 		.name		= "led0",
-		.gpio		= GPIO_PORT0,
+		.gpio		= 0,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name		= "led1",
-		.gpio		= GPIO_PORT1,
+		.gpio		= 1,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name		= "led2",
-		.gpio		= GPIO_PORT2,
+		.gpio		= 2,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name		= "led3",
-		.gpio		= GPIO_PORT159,
+		.gpio		= 159,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}
 };
@@ -964,11 +964,11 @@ static struct platform_device nand_flash_device = {
 
 /*
  * The card detect pin of the top SD/MMC slot (CN7) is active low and is
- * connected to GPIO A22 of SH7372 (GPIO_PORT41).
+ * connected to GPIO A22 of SH7372 (GPIO 41).
  */
 static int slot_cn7_get_cd(struct platform_device *pdev)
 {
-	return !gpio_get_value(GPIO_PORT41);
+	return !gpio_get_value(41);
 }
 
 /* SDHI0 */
@@ -977,7 +977,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.cd_gpio	= GPIO_PORT172,
+	.cd_gpio	= 172,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -1060,11 +1060,11 @@ static struct platform_device sdhi1_device = {
 
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
+ * connected to GPIO SCIFB_SCK of SH7372 (162).
  */
 static int slot_cn23_get_cd(struct platform_device *pdev)
 {
-	return !gpio_get_value(GPIO_PORT162);
+	return !gpio_get_value(162);
 }
 
 /* SDHI2 */
@@ -1403,9 +1403,9 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
 	/* backlight, off by default */
-	gpio_request_one(GPIO_PORT31, GPIOF_OUT_INIT_LOW, NULL);
+	gpio_request_one(31, GPIOF_OUT_INIT_LOW, NULL);
 
-	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
+	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	/* USBHS0 */
 	gpio_request(GPIO_FN_VBUS0_0, NULL);
@@ -1421,10 +1421,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
+	gpio_request_one(161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
 
-	gpio_request(GPIO_PORT9,  NULL);
-	gpio_request(GPIO_PORT10, NULL);
+	gpio_request(9,  NULL);
+	gpio_request(10, NULL);
 	gpio_direction_none(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
@@ -1475,7 +1475,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID1_0, NULL);
 #endif
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
+	gpio_request_one(41, GPIOF_IN, NULL);
 
 	/* enable SDHI2 */
 	gpio_request(GPIO_FN_SDHICMD2, NULL);
@@ -1486,7 +1486,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_0, NULL);
 
 	/* card detect pin for microSD slot (CN23) */
-	gpio_request_one(GPIO_PORT162, GPIOF_IN, NULL);
+	gpio_request_one(162, GPIOF_IN, NULL);
 
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
-- 
1.7.10.4
