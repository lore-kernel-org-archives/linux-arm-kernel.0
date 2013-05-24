From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:57 +0200
Subject: [PATCH 20/21] arm: kirkwood: openblocks-a6: group pinmux
 configurations
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having one separate pinmux configuration for each LED, for
each GPIO of the GPIO header, for each DIP switch, this patch groups
them together in configurations that make sense together: LEDs on one
side, GPIOs of the GPIO header on another side, and DIP switches on
yet another side.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   82 +++-----------------------
 1 file changed, 9 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index a05b382..56e3161 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -83,12 +83,7 @@
 		};
 
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = <&pmx_dip_sw0 &pmx_dip_sw1
-				     &pmx_dip_sw2 &pmx_dip_sw3
-				     &pmx_gpio_0 &pmx_gpio_1
-				     &pmx_gpio_2 &pmx_gpio_3
-				     &pmx_gpio_4 &pmx_gpio_5
-				     &pmx_gpio_6 &pmx_gpio_7>;
+			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -108,63 +103,14 @@
 				marvell,function = "sysrst";
 			};
 
-			pmx_dip_sw0: pmx-dip-sw0 {
-				marvell,pins = "mpp20";
+			pmx_dip_switches: pmx-dip-switches {
+				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23";
 				marvell,function = "gpio";
 			};
 
-			pmx_dip_sw1: pmx-dip-sw1 {
-				marvell,pins = "mpp21";
-				marvell,function = "gpio";
-			};
-
-			pmx_dip_sw2: pmx-dip-sw2 {
-				marvell,pins = "mpp22";
-				marvell,function = "gpio";
-			};
-
-			pmx_dip_sw3: pmx-dip-sw3 {
-				marvell,pins = "mpp23";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_0: pmx-gpio-0 {
-				marvell,pins = "mpp24";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_1: pmx-gpio-1 {
-				marvell,pins = "mpp25";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_2: pmx-gpio-2 {
-				marvell,pins = "mpp26";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_3: pmx-gpio-3 {
-				marvell,pins = "mpp27";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_4: pmx-gpio-4 {
-				marvell,pins = "mpp28";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_5: pmx-gpio-5 {
-				marvell,pins = "mpp29";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_6: pmx-gpio-6 {
-				marvell,pins = "mpp30";
-				marvell,function = "gpio";
-			};
-
-			pmx_gpio_7: pmx-gpio-7 {
-				marvell,pins = "mpp31";
+			pmx_gpio_header: pmx-gpio-header {
+				marvell,pins = "mpp24", "mpp25", "mpp26", "mpp27",
+					       "mpp28", "mpp29", "mpp30", "mpp31";
 				marvell,function = "gpio";
 			};
 
@@ -178,18 +124,8 @@
 				marvell,function = "gpio";
 			};
 
-			pmx_led_red: pmx-led-red {
-				marvell,pins = "mpp41";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_green: pmx-led-green {
-				marvell,pins = "mpp42";
-				marvell,function = "gpio";
-			};
-
-			pmx_led_yellow: pmx-led-yellow {
-				marvell,pins = "mpp43";
+			pmx_leds: pmx-leds {
+				marvell,pins = "mpp41", "mpp42", "mpp43";
 				marvell,function = "gpio";
 			};
 		};
@@ -197,7 +133,7 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
-		pinctrl-0 = <&pmx_led_red &pmx_led_green &pmx_led_yellow>;
+		pinctrl-0 = <&pmx_leds>;
 		pinctrl-names = "default";
 
 		led-red {
-- 
1.7.9.5
