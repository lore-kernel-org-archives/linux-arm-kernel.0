From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:33 +0900
Subject: [PATCH 3/5] ARM: shmobile: armadillo800eva legacy: Add LED support
In-Reply-To: <cover.1403681531.git.horms+renesas@verge.net.au>
References: <cover.1403681531.git.horms+renesas@verge.net.au>
Message-ID: <111bcc1360235ad1cdab4bc27f5ccca943ca8af5.1403681531.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Cfr. r8a7740-armadillo800eva-reference.dts

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 53d03e8..395638d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -578,6 +578,40 @@ static struct platform_device hdmi_lcdc_device = {
 	},
 };
 
+/* LEDS */
+static struct gpio_led gpio_leds[] = {
+	{
+		.name		= "LED3",
+		.gpio		= 102,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED4",
+		.gpio		= 111,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED5",
+		.gpio		= 110,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED6",
+		.gpio		= 177,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data leds_gpio_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio_device = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &leds_gpio_info,
+	},
+};
+
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1, __VA_ARGS__ }
@@ -1069,6 +1103,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
 	&pwm_device,
 	&pwm_backlight_device,
+	&leds_gpio_device,
 	&gpio_keys_device,
 	&sh_eth_device,
 	&vcc_sdhi0,
-- 
2.0.0.rc2
