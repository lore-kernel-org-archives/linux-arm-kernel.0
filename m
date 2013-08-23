From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:04 +0100
Subject: [PATCH 04/40] ARM: ux500: Remove ATAG booting support for Snowball's
 heatbeat LED
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b090d4d..e634ea5 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -55,26 +55,6 @@
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
 
-static struct gpio_led snowball_led_array[] = {
-	{
-		.name = "user_led",
-		.default_trigger = "heartbeat",
-		.gpio = 142,
-	},
-};
-
-static struct gpio_led_platform_data snowball_led_data = {
-	.leds = snowball_led_array,
-	.num_leds = ARRAY_SIZE(snowball_led_array),
-};
-
-static struct platform_device snowball_led_dev = {
-	.name = "leds-gpio",
-	.dev = {
-		.platform_data = &snowball_led_data,
-	},
-};
-
 static struct fixed_voltage_config snowball_gpio_en_3v3_data = {
        .supply_name            = "EN-3V3",
        .gpio                   = SNOWBALL_EN_3V3_ETH_GPIO,
@@ -480,7 +460,6 @@ static void __init u8500_cryp1_hash1_init(struct device *parent)
 }
 
 static struct platform_device *snowball_platform_devs[] __initdata = {
-	&snowball_led_dev,
 	&snowball_key_dev,
 	&snowball_sbnet_dev,
 	&snowball_gpio_en_3v3_regulator_dev,
-- 
1.8.1.2
