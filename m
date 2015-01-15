From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Jan 2015 23:50:15 +0800
Subject: [PATCH v2] ARM: dts: sun6i: Convert hummingbird a31 dts to label
 references
Message-ID: <1421337015-4669-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using label references is preferred when override settings from the
included dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Adapting the alphabetical ordering discussed during v1 changes almost
the whole file.

---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 181 ++++++++++++++--------------
 1 file changed, 88 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index ebd5f7854b1b..8b61b1b342e0 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -61,101 +61,96 @@
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
+};
+
+&ehci0 {
+	status = "okay";
+};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
-			vmmc-supply = <&reg_vcc3v0>;
-			bus-width = <4>;
-			cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		usbphy: phy at 01c19400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
-		};
-
-		ehci0: usb at 01c1a000 {
-			status = "okay";
-		};
-
-		ohci0: usb at 01c1a400 {
-			status = "okay";
-		};
-
-		pio: pinctrl at 01c20800 {
-			mmc0_pins_a: mmc0 at 0 {
-				/* external pull-ups missing for some pins */
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
-				allwinner,pins = "PA8";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-				allwinner,pins = "PH24";
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
-
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			/* pull-ups and devices require AXP221 DLDO3 */
-			status = "failed";
-		};
-
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
-
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-
-			pcf8563: rtc at 51 {
-				compatible = "nxp,pcf8563";
-				reg = <0x51>;
-			};
-		};
-
-		gmac: ethernet at 01c30000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_rgmii_a>;
-			phy = <&phy1>;
-			phy-mode = "rgmii";
-			snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
-			snps,reset-active-low;
-			snps,reset-delays-us = <0 10000 30000>;
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 30000>;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
 	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	/* pull-ups and devices require AXP221 DLDO3 */
+	status = "failed";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+
+	pcf8563: rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc0_pins_a {
+	/* external pull-ups missing for some pins */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_a>;
-		gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
-		status = "okay";
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
+		allwinner,pins = "PA8";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 };
+
+&reg_usb1_vbus {
+	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb1_vbus_pin_a {
+	/* different pin from sunxi-common-regulators */
+	allwinner,pins = "PH24";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.1.4
