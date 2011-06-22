From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 22 Jun 2011 19:31:49 +0000
Subject: [PATCH REPOST] pxa/hx4700: Add ASIC3 LED support
Message-ID: <E1QZT9S-0004Vb-Hv@outmx03.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LED support for the HTC ASIC3. Underlying support is provided by the mfd/asic3 and leds/leds-asic3 drivers. An example configuration is provided by the pxa/hx4700 platform.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

This part of the HTC ASIC3 LED driver patch set was seemingly dropped, hence repost.

--- clean-3.0-rc4/arch/arm/mach-pxa/hx4700.c	2011-06-21 04:25:46.000000000 +0100
+++ linux-3.0-rc4/arch/arm/mach-pxa/hx4700.c	2011-06-22 10:43:18.986382990 +0100
@@ -280,6 +280,21 @@ static u16 asic3_gpio_config[] = {
 	ASIC3_GPIOD15_nPIOW,
 };
 
+static struct asic3_led asic3_leds[ASIC3_NUM_LEDS] = {
+	[0] = {
+		.name = "hx4700:amber",
+		.default_trigger = "ds2760-battery.0-charging-blink-full-solid",
+	},
+	[1] = {
+		.name = "hx4700:green",
+		.default_trigger = "unused",
+	},
+	[2] = {
+		.name = "hx4700:blue",
+		.default_trigger = "hx4700-radio",
+	},
+};
+
 static struct resource asic3_resources[] = {
 	/* GPIO part */
 	[0] = {
@@ -310,6 +325,7 @@ static struct asic3_platform_data asic3_
 	.gpio_config_num = ARRAY_SIZE(asic3_gpio_config),
 	.irq_base        = IRQ_BOARD_START,
 	.gpio_base       = HX4700_ASIC3_GPIO_BASE,
+	.leds            = asic3_leds,
 };
 
 static struct platform_device asic3 = {
