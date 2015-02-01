From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:07 +0100
Subject: [PATCH 23/30] ARM: sun7i: hummingbird: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-24-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts | 384 ++++++++++++++--------------
 1 file changed, 191 insertions(+), 193 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 2a9ee72b2b4a..8c30e126abe6 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -67,199 +67,6 @@
 		serial4 = &uart5;
 	};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-			vmmc-supply = <&reg_vcc3v0>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		mmc3: mmc at 01c12000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc3_pins_a>;
-			vmmc-supply = <&reg_mmc3_vdd>;
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
-		pio: pinctrl at 01c20800 {
-			ahci_pwr_pin_a20_hummingbird: ahci_pwr_pin at 0 {
-				allwinner,pins = "PH15";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb1_vbus_pin_a20_hummingbird: usb1_vbus_pin at 0 {
-				allwinner,pins = "PH2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc3_vdd_pin_a20_hummingbird: mmc3_vdd_pin at 0 {
-				allwinner,pins = "PH9";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			gmac_vdd_pin_a20_hummingbird: gmac_vdd_pin at 0 {
-				allwinner,pins = "PH16";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		pwm: pwm at 01c20e00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pwm0_pins_a>;
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
-		uart2: serial at 01c28800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart2_pins_a>;
-			status = "okay";
-		};
-
-		uart3: serial at 01c28c00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart3_pins_a>;
-			status = "okay";
-		};
-
-		uart4: serial at 01c29000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart4_pins_a>;
-			status = "okay";
-		};
-
-		uart5: serial at 01c29400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart5_pins_a>;
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
-				interrupt-controller;
-				#interrupt-cells = <1>;
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
-		i2c3: i2c at 01c2b800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c3_pins_a>;
-			status = "okay";
-		};
-
-		spi2: spi at 01c17000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi2_pins_b>;
-			status = "okay";
-		};
-
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_rgmii_a>;
-			phy = <&phy1>;
-			phy-mode = "rgmii";
-			phy-supply = <&reg_gmac_vdd>;
-			/* phy reset config */
-			snps,reset-gpio = <&pio 0 17 GPIO_ACTIVE_HIGH>; /* PA17 */
-			snps,reset-active-low;
-			/* wait 1s after reset, otherwise fail to read phy id */
-			snps,reset-delays-us = <0 10000 1000000>;
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
-	};
-
-	reg_ahci_5v: ahci-5v {
-		pinctrl-0 = <&ahci_pwr_pin_a20_hummingbird>;
-		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
-		status = "okay";
-	};
-
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_a20_hummingbird>;
-		gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
-		status = "okay";
-	};
-
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
-
 	reg_mmc3_vdd: mmc3_vdd {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -282,3 +89,194 @@
 		gpio = <&pio 7 16 GPIO_ACTIVE_HIGH>; /* PH16 */
 	};
 };
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
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
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	phy-supply = <&reg_gmac_vdd>;
+	/* phy reset config */
+	snps,reset-gpio = <&pio 0 17 GPIO_ACTIVE_HIGH>; /* PA17 */
+	snps,reset-active-low;
+	/* wait 1s after reset, otherwise fail to read phy id */
+	snps,reset-delays-us = <0 10000 1000000>;
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
+		interrupt-controller;
+		#interrupt-cells = <1>;
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
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_a>;
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
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>;
+	vmmc-supply = <&reg_mmc3_vdd>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
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
+	ahci_pwr_pin_a20_hummingbird: ahci_pwr_pin at 0 {
+		allwinner,pins = "PH15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb1_vbus_pin_a20_hummingbird: usb1_vbus_pin at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc3_vdd_pin_a20_hummingbird: mmc3_vdd_pin at 0 {
+		allwinner,pins = "PH9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	gmac_vdd_pin_a20_hummingbird: gmac_vdd_pin at 0 {
+		allwinner,pins = "PH16";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_a20_hummingbird>;
+	gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_a20_hummingbird>;
+	gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_b>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_a>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_a>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_pins_a>;
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
