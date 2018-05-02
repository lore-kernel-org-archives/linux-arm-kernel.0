From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 09:51:38 +0200
Subject: [PATCH] ARM: dts: stm32: Fix DTC warnings for stm32mp157
Message-ID: <1525247498-12834-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix DTC warnings for stm32mp157:

Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller/uart4 at 0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /soc/pin-controller-z: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..8534371 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	soc {
-		pinctrl: pin-controller {
+		pinctrl: pin-controller at 50002000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32mp157-pinctrl";
@@ -146,7 +146,7 @@
 				gpio-ranges = <&pinctrl 0 160 8>;
 			};
 
-			uart4_pins_a: uart4 at 0 {
+			uart4_pins_a: uart4-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
 					bias-disable;
@@ -160,7 +160,7 @@
 			};
 		};
 
-		pinctrl_z: pin-controller-z {
+		pinctrl_z: pin-controller-z at 54004000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32mp157-z-pinctrl";
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9f90337a..86ede40 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -16,7 +16,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at c0000000 {
 		reg = <0xC0000000 0x40000000>;
 	};
 
-- 
2.7.4
