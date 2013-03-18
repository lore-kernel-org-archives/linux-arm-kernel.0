From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:22 +0900
Subject: [PATCH 026/142] ARM: shmobile: armadillo: Replace GPIO_PORTx enum
 with GPIO port numbers
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-27-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC GPIO API implementation moved to using port numbers. Replace all
GPIO_PORTx enum usage with the corresponding port number. The GPIO_PORTx
enum values are identical to the port number on this platform.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   58 ++++++++++++------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f2ec077..92d7991 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -227,7 +227,7 @@ static void usbhsf_power_ctrl(struct platform_device *pdev,
 
 static int usbhsf_get_vbus(struct platform_device *pdev)
 {
-	return gpio_get_value(GPIO_PORT209);
+	return gpio_get_value(209);
 }
 
 static irqreturn_t usbhsf_interrupt(int irq, void *data)
@@ -535,10 +535,10 @@ static struct platform_device hdmi_lcdc_device = {
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1, __VA_ARGS__ }
 
 static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3", .wakeup = 1),
-	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW4"),
-	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW5"),
-	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW6"),
+	GPIO_KEY(KEY_POWER,	99,	"SW3", .wakeup = 1),
+	GPIO_KEY(KEY_BACK,	100,	"SW4"),
+	GPIO_KEY(KEY_MENU,	97,	"SW5"),
+	GPIO_KEY(KEY_HOME,	98,	"SW6"),
 };
 
 static struct gpio_keys_platform_data gpio_key_info = {
@@ -708,9 +708,9 @@ static int mt9t111_power(struct device *dev, int mode)
 		/* video1 (= CON1 camera) expect 24MHz */
 		clk_set_rate(mclk, clk_round_rate(mclk, 24000000));
 		clk_enable(mclk);
-		gpio_set_value(GPIO_PORT158, 1);
+		gpio_set_value(158, 1);
 	} else {
-		gpio_set_value(GPIO_PORT158, 0);
+		gpio_set_value(158, 0);
 		clk_disable(mclk);
 	}
 
@@ -864,8 +864,8 @@ static struct platform_device fsi_hdmi_device = {
 
 /* RTC: RTC connects i2c-gpio. */
 static struct i2c_gpio_platform_data i2c_gpio_data = {
-	.sda_pin	= GPIO_PORT208,
-	.scl_pin	= GPIO_PORT91,
+	.sda_pin	= 208,
+	.scl_pin	= 91,
 	.udelay		= 5, /* 100 kHz */
 };
 
@@ -1000,12 +1000,12 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_LCD0_DISP,		NULL);
 	gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
-	gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
-	gpio_request_one(GPIO_PORT202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
+	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
+	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
-	gpio_request_one(GPIO_PORT166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
+	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
@@ -1028,12 +1028,12 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
 	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
 
-	gpio_request_one(GPIO_PORT18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
+	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
 	/* USB */
-	gpio_request_one(GPIO_PORT159, GPIOF_IN, NULL); /* USB_DEVICE_MODE */
+	gpio_request_one(159, GPIOF_IN, NULL); /* USB_DEVICE_MODE */
 
-	if (gpio_get_value(GPIO_PORT159)) {
+	if (gpio_get_value(159)) {
 		/* USB Host */
 	} else {
 		/* USB Func */
@@ -1042,10 +1042,10 @@ static void __init eva_init(void)
 		 * OTOH, usbhs interrupt needs its value (HI/LOW) to decide
 		 * USB connection/disconnection (usbhsf_get_vbus()).
 		 * This means we needs to select GPIO_FN_IRQ7_PORT209 first,
-		 * and select GPIO_PORT209 here
+		 * and select GPIO 209 here
 		 */
 		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
-		gpio_request_one(GPIO_PORT209, GPIOF_IN, NULL);
+		gpio_request_one(209, GPIOF_IN, NULL);
 
 		platform_device_register(&usbhsf_device);
 		usb = &usbhsf_device;
@@ -1060,9 +1060,9 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_SDHI0_D3, NULL);
 	gpio_request(GPIO_FN_SDHI0_WP, NULL);
 
-	gpio_request_one(GPIO_PORT17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
-	gpio_request_one(GPIO_PORT74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
-	gpio_request_one(GPIO_PORT75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
+	gpio_request_one(17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
+	gpio_request_one(74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
+	gpio_request_one(75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
 
 	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
 
@@ -1099,10 +1099,10 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_VIO_CKO,		NULL);
 
 	/* CON1/CON15 Camera */
-	gpio_request_one(GPIO_PORT173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
-	gpio_request_one(GPIO_PORT172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
+	gpio_request_one(173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
+	gpio_request_one(172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
 	/* see mt9t111_power() */
-	gpio_request_one(GPIO_PORT158, GPIOF_OUT_INIT_LOW, NULL);  /* CAM_PON */
+	gpio_request_one(158, GPIOF_OUT_INIT_LOW, NULL);  /* CAM_PON */
 
 	/* FSI-WM8978 */
 	gpio_request(GPIO_FN_FSIAIBT,		NULL);
@@ -1111,8 +1111,8 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_FSIAOSLD,		NULL);
 	gpio_request(GPIO_FN_FSIAISLD_PORT5,	NULL);
 
-	gpio_request(GPIO_PORT7, NULL);
-	gpio_request(GPIO_PORT8, NULL);
+	gpio_request(7, NULL);
+	gpio_request(8, NULL);
 	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
@@ -1129,14 +1129,14 @@ static void __init eva_init(void)
 	 * DBGMD/LCDC0/FSIA MUX
 	 * DBGMD_SELECT_B should be set after setting PFC Function.
 	 */
-	gpio_request_one(GPIO_PORT176, GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_request_one(176, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/*
 	 * We can switch CON8/CON14 by SW1.5,
 	 * but it needs after DBGMD_SELECT_B
 	 */
-	gpio_request_one(GPIO_PORT6, GPIOF_IN, NULL);
-	if (gpio_get_value(GPIO_PORT6)) {
+	gpio_request_one(6, GPIOF_IN, NULL);
+	if (gpio_get_value(6)) {
 		/* CON14 enable */
 	} else {
 		/* CON8 (SDHI1) enable */
@@ -1150,7 +1150,7 @@ static void __init eva_init(void)
 		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
 
 		/* SDSLOT2_PON */
-		gpio_request_one(GPIO_PORT16, GPIOF_OUT_INIT_HIGH, NULL);
+		gpio_request_one(16, GPIOF_OUT_INIT_HIGH, NULL);
 
 		platform_device_register(&sdhi1_device);
 	}
-- 
1.7.10.4
