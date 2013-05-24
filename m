From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:45 +0200
Subject: [PATCH 08/21] arm: kirkwood: iconnect: give meaningful names to
 pinmux configs
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood iConnect Device Tree is currently using totally
meaningless names for the pinmux configuration: pmx_gpio_XY.

This patch fixes that by using some more meaningful names such as
pmx_button_power.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-iconnect.dts |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 12ccf74..20c3ece 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -21,50 +21,50 @@
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
-			pinctrl-0 = < &pmx_gpio_12 &pmx_gpio_35
-				      &pmx_gpio_41 &pmx_gpio_42
-				      &pmx_gpio_43 &pmx_gpio_44
-				      &pmx_gpio_45 &pmx_gpio_46
-				      &pmx_gpio_47 &pmx_gpio_48 >;
+			pinctrl-0 = < &pmx_button_reset &pmx_button_otb
+				      &pmx_led_level &pmx_led_power_blue
+				      &pmx_led_power_red &pmx_led_usb1
+				      &pmx_led_usb2 &pmx_led_usb3
+				      &pmx_led_usb4 &pmx_led_otb >;
 			pinctrl-names = "default";
 
-			pmx_gpio_12: pmx-gpio-12 {
+			pmx_button_reset: pmx-button-reset {
 				marvell,pins = "mpp12";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_35: pmx-gpio-35 {
+			pmx_button_otb: pmx-button-otb {
 				marvell,pins = "mpp35";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_41: pmx-gpio-41 {
+			pmx_led_level: pmx-led-level {
 				marvell,pins = "mpp41";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_42: pmx-gpio-42 {
+			pmx_led_power_blue: pmx-led-power-blue {
 				marvell,pins = "mpp42";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_43: pmx-gpio-43 {
+			pmx_led_power_red: pmx-power-red {
 				marvell,pins = "mpp43";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_44: pmx-gpio-44 {
+			pmx_led_usb1: pmx-led-usb1 {
 				marvell,pins = "mpp44";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_45: pmx-gpio-45 {
+			pmx_led_usb2: pmx-led-usb2 {
 				marvell,pins = "mpp45";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_46: pmx-gpio-46 {
+			pmx_led_usb3: pmx-led-usb3 {
 				marvell,pins = "mpp46";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_47: pmx-gpio-47 {
+			pmx_led_usb4: pmx-led-usb4 {
 				marvell,pins = "mpp47";
 				marvell,function = "gpio";
 			};
-			pmx_gpio_48: pmx-gpio-48 {
+			pmx_led_otb: pmx-led-otb {
 				marvell,pins = "mpp48";
 				marvell,function = "gpio";
 			};
-- 
1.7.9.5
