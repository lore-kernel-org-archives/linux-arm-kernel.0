From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:57 +0100
Subject: [PATCH 13/30] ARM: sun5i: a10s: r7 tv dongle: Convert to DT label
 based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts | 132 +++++++++++++-------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 7deddfc9df8b..d42ce170e640 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -56,69 +56,6 @@
 	model = "R7 A10s hdmi tv-stick";
 	compatible = "allwinner,r7-tv-dongle", "allwinner,sun5i-a10s";
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		mmc1: mmc at 01c10000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc1_pins_a>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			non-removable;
-			status = "okay";
-		};
-
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
-		};
-
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
-
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
-
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_r7: mmc0_cd_pin at 0 {
-				allwinner,pins = "PG1";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			led_pins_r7: led_pins at 0 {
-				allwinner,pins = "PB2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb1_vbus_pin_r7: usb1_vbus_pin at 0 {
-				allwinner,pins = "PG13";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -130,10 +67,71 @@
 			default-state = "on";
 		};
 	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_r7: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG1";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	led_pins_r7: led_pins at 0 {
+		allwinner,pins = "PB2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_r7>;
-		gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	usb1_vbus_pin_r7: usb1_vbus_pin at 0 {
+		allwinner,pins = "PG13";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_r7>;
+	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.2.2
