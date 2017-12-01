From: venkataravi.e@techveda.org (venkataravi.e at techveda.org)
Date: Fri,  1 Dec 2017 12:08:28 +0530
Subject: [PATCH 1/4] arm: dts: imx28: Use phandles instead of unit addresses
In-Reply-To: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
References: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
Message-ID: <1512110311-15788-2-git-send-email-venkataravi.e@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravi Eluri <venkataravi.e@techveda.org>

Unit addresses for all peripherals of imx28 are defined in
the corresponding dtsi file, use phandles instead of unit addresses
to reference peripheral nodes in dts files. This makes the DT more
robust and readable.

Signed-off-by: Ravi Eluri <venkataravi.e@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- This is the first patch of the four patch series.
- Patch was compile tested and built(ARCH=arm, imx28) on linux-next
  (latest).
- No build issues reported.
- Please discard this changeset, if this is not making any better.
---
 arch/arm/boot/dts/imx28-evk.dts | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 7f5b804..21ac4fa 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -22,14 +22,14 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
-			gpmi-nand at 8000c000 {
+			&gpmi {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
 					     &gpmi_pins_evk>;
 				status = "okay";
 			};
 
-			ssp0: ssp at 80010000 {
+			&ssp0 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
 				pinctrl-0 = <&mmc0_8bit_pins_a
@@ -40,13 +40,13 @@
 				status = "okay";
 			};
 
-			ssp1: ssp@80012000 {
+			&ssp1 {
 				compatible = "fsl,imx28-mmc";
 				bus-width = <8>;
 				wp-gpios = <&gpio0 28 0>;
 			};
 
-			ssp2: ssp at 80014000 {
+			&ssp2 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx28-spi";
@@ -63,7 +63,7 @@
 				};
 			};
 
-			pinctrl at 80018000 {
+			&pinctrl {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
@@ -119,7 +119,7 @@
 				};
 			};
 
-			lcdif at 80030000 {
+			&lcdif {
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
@@ -152,14 +152,14 @@
 				};
 			};
 
-			can0: can at 80032000 {
+			&can0 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can0_pins_a>;
 				xceiver-supply = <&reg_can_3v3>;
 				status = "okay";
 			};
 
-			can1: can at 80034000 {
+			&can1 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can1_pins_a>;
 				xceiver-supply = <&reg_can_3v3>;
@@ -168,20 +168,20 @@
 		};
 
 		apbx at 80040000 {
-			saif0: saif at 80042000 {
+			&saif0 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif0_pins_a>;
 				status = "okay";
 			};
 
-			saif1: saif at 80046000 {
+			&saif1 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif1_pins_a>;
 				fsl,saif-master = <&saif0>;
 				status = "okay";
 			};
 
-			lradc at 80050000 {
+			&lradc {
 				status = "okay";
 				fsl,lradc-touchscreen-wires = <4>;
 				fsl,ave-ctrl = <4>;
@@ -189,7 +189,7 @@
 				fsl,settling = <10>;
 			};
 
-			i2c0: i2c at 80058000 {
+			&i2c0 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
 				status = "okay";
@@ -209,55 +209,55 @@
 				};
 			};
 
-			pwm: pwm at 80064000 {
+			&pwm {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pwm2_pins_a>;
 				status = "okay";
 			};
 
-			duart: serial at 80074000 {
+			&duart {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
 
-			auart0: serial at 8006a000 {
+			&auart0 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
 				uart-has-rtscts;
 				status = "okay";
 			};
 
-			auart3: serial at 80070000 {
+			&auart3 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart3_pins_a>;
 				status = "okay";
 			};
 
-			usbphy0: usbphy at 8007c000 {
+			&usbphy0 {
 				status = "okay";
 			};
 
-			usbphy1: usbphy at 8007e000 {
+			&usbphy1 {
 				status = "okay";
 			};
 		};
 	};
 
 	ahb at 80080000 {
-		usb0: usb at 80080000 {
+		&usb0 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_id_pins_a>;
 			vbus-supply = <&reg_usb0_vbus>;
 			status = "okay";
 		};
 
-		usb1: usb at 80090000 {
+		&usb1 {
 			vbus-supply = <&reg_usb1_vbus>;
 			status = "okay";
 		};
 
-		mac0: ethernet at 800f0000 {
+		&mac0 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
@@ -267,7 +267,7 @@
 			status = "okay";
 		};
 
-		mac1: ethernet at 800f4000 {
+		&mac1 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac1_pins_a>;
-- 
1.9.1
