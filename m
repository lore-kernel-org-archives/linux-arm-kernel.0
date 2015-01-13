From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:29 +0800
Subject: [PATCH v3 07/13] ARM: dts: sunxi: Use label to reference pio in
 sunxi-common-regulators
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the label to reference the pin controller node, so that we can use
sunxi-common-regulators with sunxi families that don't share the same
address space mappings, such as sun9i.

This patch is mostly space changes due to the reduction of node parents.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 54 +++++++++++++-------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index b1d64dd183f4..e02baa66b33c 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -50,39 +50,37 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
-/ {
-	soc at 01c00000 {
-		pio: pinctrl at 01c20800 {
-			ahci_pwr_pin_a: ahci_pwr_pin at 0 {
-				allwinner,pins = "PB8";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
+&pio {
+	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
+		allwinner,pins = "PB8";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-				allwinner,pins = "PB9";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
+	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+		allwinner,pins = "PB9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-				allwinner,pins = "PH6";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
+	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+		allwinner,pins = "PH6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-			usb2_vbus_pin_a: usb2_vbus_pin at 0 {
-				allwinner,pins = "PH3";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
+		allwinner,pins = "PH3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+};
 
+/ {
 	reg_ahci_5v: ahci-5v {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.1.4
