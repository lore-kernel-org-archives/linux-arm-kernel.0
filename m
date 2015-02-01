From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:06 +0100
Subject: [PATCH 22/30] ARM: sun7i: cubietruck: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-23-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 316 ++++++++++++++---------------
 1 file changed, 157 insertions(+), 159 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8f74a649576d..0c219a419f49 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -59,144 +59,6 @@
 	model = "Cubietech Cubietruck";
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
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
-			usb0_vbus-supply = <&reg_usb0_vbus>;
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
-		ahci: sata at 01c18000 {
-			target-supply = <&reg_ahci_5v>;
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
-				/* AP6210 requires pull-up */
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			vmmc3_pin_cubietruck: vmmc3_pin at 0 {
-				allwinner,pins = "PH9";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
-				allwinner,pins = "PH12";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			led_pins_cubietruck: led_pins at 0 {
-				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-				allwinner,pins = "PH17";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		pwm: pwm at 01c20e00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
-			status = "okay";
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
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-			};
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
-		};
-
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_rgmii_a>;
-			phy = <&phy1>;
-			phy-mode = "rgmii";
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
@@ -223,26 +85,6 @@
 		};
 	};
 
-	reg_ahci_5v: ahci-5v {
-		pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
-		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
-
-	reg_usb0_vbus: usb0-vbus {
-		pinctrl-0 = <&usb0_vbus_pin_a>;
-		gpio = <&pio 7 17 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
-
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
@@ -255,12 +97,141 @@
 	};
 };
 
-#include "axp209.dtsi"
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
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
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
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
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
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
+	/* AP6210 requires pull-up */
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
+	vmmc3_pin_cubietruck: vmmc3_pin at 0 {
+		allwinner,pins = "PH9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
+		allwinner,pins = "PH12";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	led_pins_cubietruck: led_pins at 0 {
+		allwinner,pins = "PH7", "PH11", "PH20", "PH21";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+		allwinner,pins = "PH17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
+	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -285,3 +256,30 @@
 	regulator-max-microvolt = <3000000>;
 	regulator-name = "avcc";
 };
+
+&reg_usb0_vbus {
+	pinctrl-0 = <&usb0_vbus_pin_a>;
+	gpio = <&pio 7 17 GPIO_ACTIVE_HIGH>;
+	status = "okay";
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
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.2.2
