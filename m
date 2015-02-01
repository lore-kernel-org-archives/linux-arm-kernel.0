From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:52 +0100
Subject: [PATCH 08/30] ARM: sun4i: inet97fv2: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 104 ++++++++++++++----------------
 1 file changed, 49 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 482914333bba..ab3bbc13db1c 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -56,71 +56,65 @@
 / {
 	model = "INet-97F Rev 02";
 	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
+};
 
-	aliases {
-		serial0 = &uart0;
-	};
-
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
+&ehci0 {
+	status = "okay";
+};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupts = <0>;
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
 
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
 
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
+&ohci0 {
+	status = "okay";
+};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
+&ohci1 {
+	status = "okay";
+};
 
-			axp209: pmic at 34 {
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupts = <0>;
+&reg_usb1_vbus {
+	status = "okay";
+};
 
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-	};
+&reg_usb2_vbus {
+	status = "okay";
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
-	};
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
 };
-- 
2.2.2
