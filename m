From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:39:51 +0200
Subject: [PATCH v4 22/26] ARM: pxa: magician: Remove pdata for pasic3-leds
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B3A7.3090701@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pasic3-leds driver was never in vanilla kernel. Actual configuration
data for a hypothetical driver does not describe hardware completely, so
remove them.

This patch prepare HTC Magician machine code to pasic3-leds driver
addition.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 44 ++------------------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 331dfd1..8a90b90 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -510,46 +510,6 @@ static struct platform_device leds_gpio = {
 };
 
 /*
- * PASIC3 LEDs
- */
-
-static struct pasic3_led pasic3_leds[] = {
-	{
-		.led = {
-			.name = "magician:red",
-			.default_trigger = "ds2760-battery.0-charging",
-		},
-		.hw_num	= 0,
-		.bit2	= PASIC3_BIT2_LED0,
-		.mask	= PASIC3_MASK_LED0,
-	},
-	{
-		.led = {
-			.name = "magician:green",
-			.default_trigger = "ds2760-battery.0-charging-or-full",
-		},
-		.hw_num	= 1,
-		.bit2	= PASIC3_BIT2_LED1,
-		.mask	= PASIC3_MASK_LED1,
-	},
-	{
-		.led = {
-			.name = "magician:blue",
-			.default_trigger = "bluetooth",
-		},
-		.hw_num	= 2,
-		.bit2	= PASIC3_BIT2_LED2,
-		.mask	= PASIC3_MASK_LED2,
-	},
-};
-
-static struct pasic3_leds_machinfo pasic3_leds_info = {
-	.num_leds	= ARRAY_SIZE(pasic3_leds),
-	.power_gpio	= EGPIO_MAGICIAN_LED_POWER,
-	.leds		= pasic3_leds,
-};
-
-/*
  * PASIC3 DS1WM
  */
 
@@ -568,8 +528,8 @@ static struct resource pasic3_resources[] = {
 };
 
 static struct pasic3_platform_data pasic3_platform_data = {
-	.led_pdata	= &pasic3_leds_info,
-	.clock_rate	= 4000000,
+/*	.led_pdata  = &pasic3_leds_info,*/
+	.clock_rate = 4000000,
 };
 
 static struct platform_device pasic3 = {
-- 
1.7.12.1
