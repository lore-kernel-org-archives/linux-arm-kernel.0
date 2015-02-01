From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:08 +0100
Subject: [PATCH 24/30] ARM: sun7i: i12 tvbox: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-25-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts | 252 +++++++++++++++---------------
 1 file changed, 125 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 06148b4d000f..baee563a0051 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -57,125 +57,6 @@
 	model = "I12 / Q5 / QT840A A20 tvbox";
 	compatible = "allwinner,i12-tvbox", "allwinner,sun7i-a20";
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		mmc3: mmc at 01c12000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc3_pins_a>;
-			vmmc-supply = <&reg_vmmc3>;
-			bus-width = <4>;
-			non-removable;
-			status = "okay";
-		};
-
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
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
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
-
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
-
-		pinctrl at 01c20800 {
-			mmc3_pins_a: mmc3 at 0 {
-				/* AP6210 / AP6330 requires pull-up */
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			vmmc3_pin_i12_tvbox: vmmc3_pin at 0 {
-				allwinner,pins = "PH2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			vmmc3_io_pin_i12_tvbox: vmmc3_io_pin at 0 {
-				allwinner,pins = "PH12";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			gmac_power_pin_i12_tvbox: gmac_power_pin at 0 {
-				allwinner,pins = "PH21";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			led_pins_i12_tvbox: led_pins at 0 {
-				allwinner,pins = "PH9", "PH20";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		ir0: ir at 01c21800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&ir0_pins_a>;
-			status = "okay";
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
-			status = "okay";
-
-			axp209: pmic at 34 {
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_mii_a>;
-			phy = <&phy1>;
-			phy-mode = "mii";
-			phy-supply = <&reg_gmac_3v3>;
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -192,14 +73,6 @@
 		};
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
-	};
-
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
-
 	reg_vmmc3: vmmc3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -236,3 +109,128 @@
 		gpio = <&pio 7 21 GPIO_ACTIVE_HIGH>;
 	};
 };
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	phy-supply = <&reg_gmac_3v3>;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>;
+	vmmc-supply = <&reg_vmmc3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&mmc3_pins_a {
+	/* AP6210 / AP6330 requires pull-up */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vmmc3_pin_i12_tvbox: vmmc3_pin at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	vmmc3_io_pin_i12_tvbox: vmmc3_io_pin at 0 {
+		allwinner,pins = "PH12";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	gmac_power_pin_i12_tvbox: gmac_power_pin at 0 {
+		allwinner,pins = "PH21";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	led_pins_i12_tvbox: led_pins at 0 {
+		allwinner,pins = "PH9", "PH20";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
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
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.2.2
