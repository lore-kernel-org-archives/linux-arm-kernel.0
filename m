From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Jan 2015 03:54:13 +0800
Subject: [PATCH v3 08/10] ARM: dts: sun9i: Enable USB support on A80 Optimus
 board
In-Reply-To: <1422388455-25923-1-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
Message-ID: <1422388455-25923-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index c4de9cb9a5f6..16d30bb3a872 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -83,6 +83,18 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins_a>;
@@ -94,6 +106,14 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
 &pio {
 	led_pins_optimus: led-pins at 0 {
 		allwinner,pins = "PH0", "PH1";
@@ -108,6 +128,20 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
+
+	usb1_vbus_pin_optimus: usb1_vbus_pin at 1 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb3_vbus_pin_optimus: usb3_vbus_pin at 1 {
+		allwinner,pins = "PH5";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &mmc0 {
@@ -129,6 +163,18 @@
 	status = "okay";
 };
 
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_optimus>;
+	gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	status = "okay";
+};
+
+&reg_usb3_vbus {
+	pinctrl-0 = <&usb3_vbus_pin_optimus>;
+	gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -145,3 +191,17 @@
 	/* Enable internal pull-up */
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
+
+&usbphy1 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usbphy3 {
+	vbus-supply = <&reg_usb3_vbus>;
+	status = "okay";
+};
-- 
2.1.4
