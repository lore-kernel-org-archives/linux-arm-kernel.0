From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:59 +0100
Subject: [PATCH 15/30] ARM: sun5i: a13: olinuxino micro: Convert to DT label
 based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-16-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts | 148 ++++++++++++------------
 1 file changed, 73 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 03deb84268ce..bdb0a094223f 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -61,93 +61,91 @@
 		serial0 = &uart1;
 	};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-			cd-inverted;
-			status = "okay";
-		};
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinom>;
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
+		power {
+			label = "a13-olinuxino-micro:green:power";
+			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
+	};
+};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
 
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
-				allwinner,pins = "PG0";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			led_pins_olinuxinom: led_pins at 0 {
-				allwinner,pins = "PG9";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
-				allwinner,pins = "PG11";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-		uart1: serial at 01c28400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart1_pins_b>;
-			status = "okay";
-		};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
+	cd-inverted;
+	status = "okay";
+};
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
+&ohci0 {
+	status = "okay";
+};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
+&pio {
+	mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG0";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxinom>;
-
-		power {
-			label = "a13-olinuxino-micro:green:power";
-			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
+	led_pins_olinuxinom: led_pins at 0 {
+		allwinner,pins = "PG9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
-		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
+		allwinner,pins = "PG11";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
+	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.2.2
