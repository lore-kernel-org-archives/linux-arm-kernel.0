From: rogershimizu@gmail.com (Roger Shimizu)
Date: Wed, 20 Jan 2016 19:44:48 +0900
Subject: [PATCH] ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl
Message-ID: <1453286688-9533-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here're a few gpio pin related fixes:
  - remove pinctrl-0 definition from pinctrl, since those pins are used
    in other places such as gpio-fan and regulators.
  - turn on power led from initial state, by change pin to active_high
    from active_low.
  - fix for alarm pin of gpio-fan.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
index 3daec91..d40b593 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree file for Buffalo Linkstation LS-WTGL
  *
- * Copyright (C) 2015, Roger Shimizu <rogershimizu@gmail.com>
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -69,8 +70,6 @@
 
 		internal-regs {
 			pinctrl: pinctrl at 10000 {
-				pinctrl-0 = <&pmx_usb_power &pmx_power_hdd
-					&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
 				pinctrl-names = "default";
 
 				pmx_led_power: pmx-leds {
@@ -161,7 +160,7 @@
 
 		led at 1 {
 			label = "lswtgl:blue:power";
-			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 2 {
@@ -188,7 +187,7 @@
 				3250 1
 				5000 0>;
 
-		alarm-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	restart_poweroff {
-- 
2.1.4
