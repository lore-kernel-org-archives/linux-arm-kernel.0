From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:21 +0900
Subject: [PATCH 025/142] ARM: shmobile: ap4-evb: Replace GPIO_PORTx enum with
 GPIO port numbers
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-26-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC GPIO API implementation moved to using port numbers. Replace all
GPIO_PORTx enum usage with the corresponding port number. The GPIO_PORTx
enum values are identical to the port number on this platform.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 38f1259..0a2b6e4 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -273,11 +273,11 @@ static struct platform_device smc911x_device = {
 
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
 /* MERAM */
 static struct sh_mobile_meram_info meram_info = {
@@ -838,22 +838,22 @@ static struct platform_device fsi_hdmi_device = {
 static struct gpio_led ap4evb_leds[] = {
 	{
 		.name			= "led4",
-		.gpio			= GPIO_PORT185,
+		.gpio			= 185,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name			= "led2",
-		.gpio			= GPIO_PORT186,
+		.gpio			= 186,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name			= "led3",
-		.gpio			= GPIO_PORT187,
+		.gpio			= 187,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 	{
 		.name			= "led1",
-		.gpio			= GPIO_PORT188,
+		.gpio			= 188,
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}
 };
@@ -1026,10 +1026,10 @@ out:
 /* TouchScreen */
 #ifdef CONFIG_AP4EVB_QHD
 # define GPIO_TSC_IRQ	GPIO_FN_IRQ28_123
-# define GPIO_TSC_PORT	GPIO_PORT123
+# define GPIO_TSC_PORT	123
 #else /* WVGA */
 # define GPIO_TSC_IRQ	GPIO_FN_IRQ7_40
-# define GPIO_TSC_PORT	GPIO_PORT40
+# define GPIO_TSC_PORT	40
 #endif
 
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
@@ -1121,10 +1121,10 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
 	/* enable Debug switch (S6) */
-	gpio_request_one(GPIO_PORT32, GPIOF_IN | GPIOF_EXPORT, NULL);
-	gpio_request_one(GPIO_PORT33, GPIOF_IN | GPIOF_EXPORT, NULL);
-	gpio_request_one(GPIO_PORT34, GPIOF_IN | GPIOF_EXPORT, NULL);
-	gpio_request_one(GPIO_PORT35, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(32, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(33, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(34, GPIOF_IN | GPIOF_EXPORT, NULL);
+	gpio_request_one(35, GPIOF_IN | GPIOF_EXPORT, NULL);
 
 	/* SDHI0 */
 	gpio_request(GPIO_FN_SDHICD0, NULL);
@@ -1172,15 +1172,15 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
+	gpio_request_one(161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
 
-	gpio_request(GPIO_PORT9, NULL);
-	gpio_request(GPIO_PORT10, NULL);
+	gpio_request(9, NULL);
+	gpio_request(10, NULL);
 	gpio_direction_none(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
+	gpio_request_one(41, GPIOF_IN, NULL);
 
 	/* setup FSI2 port B (HDMI) */
 	gpio_request(GPIO_FN_FSIBCK, NULL);
@@ -1268,8 +1268,8 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request_one(GPIO_PORT189, GPIOF_OUT_INIT_HIGH, NULL); /* backlight */
-	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
+	gpio_request_one(189, GPIOF_OUT_INIT_HIGH, NULL); /* backlight */
+	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	lcdc_info.clock_source			= LCDC_CLK_BUS;
 	lcdc_info.ch[0].interface_type		= RGB18;
-- 
1.7.10.4
