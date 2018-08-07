From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 7 Aug 2018 14:54:58 +0200
Subject: [PATCH v2 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
In-Reply-To: <1533646500-4028-1-git-send-email-patrice.chotard@st.com>
References: <1533646500-4028-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1533646500-4028-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Fix the following DT dtc warnings:

Warning (node_name_chars_strict): /clocks/i2s_ckin: Character '_' not recommended in node name
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
Warning (unique_unit_address): /soc/pin-controller/i2c1 at 0: duplicate unit-address (also used in node /soc/pin-controller/usart1 at 0)
Warning (unique_unit_address): /soc/pin-controller/i2c1 at 0: duplicate unit-address (also used in node /soc/pin-controller/usart2 at 0)
Warning (unique_unit_address): /soc/pin-controller/usart1 at 0: duplicate unit-address (also used in node /soc/pin-controller/usart2 at 0)
Warning (unique_unit_address): /soc/pin-controller/i2c1 at 0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs at 0)
Warning (unique_unit_address): /soc/pin-controller/usart1 at 0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs at 0)
Warning (unique_unit_address): /soc/pin-controller/usart2 at 0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs at 0)
Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs at 0: node has a unit name, but no reg property
Warning (avoid_unnecessary_addr_size): /soc/timer at 58002c00: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
Warning (avoid_unnecessary_addr_size): /soc/timer at 58003000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
Change since v1:
	- update nodes name as following: <node_name>@0 to <node_name>-0


 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++-----
 arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++----
 arch/arm/boot/dts/stm32h743i-disco.dts   |  2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts    |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 24be8e63dec8..fa0cde73dbe9 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -44,7 +44,7 @@
 
 / {
 	soc {
-		pin-controller {
+		pin-controller at 58020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32h743-pinctrl";
@@ -163,7 +163,7 @@
 				#interrupt-cells = <2>;
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
+			i2c1_pins_a: i2c1-0 {
 				pins {
 					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
 						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
@@ -173,7 +173,7 @@
 				};
 			};
 
-			usart1_pins: usart1 at 0 {
+			usart1_pins: usart1-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
 					bias-disable;
@@ -186,7 +186,7 @@
 				};
 			};
 
-			usart2_pins: usart2 at 0 {
+			usart2_pins: usart2-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
 					bias-disable;
@@ -199,7 +199,7 @@
 				};
 			};
 
-			usbotg_hs_pins_a: usbotg-hs at 0 {
+			usbotg_hs_pins_a: usbotg-hs-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
 							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 637beffe5067..b2d4e0b5a9c3 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -40,13 +40,15 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32h7-clks.h>
 #include <dt-bindings/mfd/stm32h7-rcc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
@@ -60,7 +62,7 @@
 			clock-frequency = <32768>;
 		};
 
-		clk_i2s: i2s_ckin {
+		clk_i2s: i2s-ckin {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
@@ -422,7 +424,6 @@
 		};
 
 		lptimer4: timer at 58002c00 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-lptimer";
 			reg = <0x58002c00 0x400>;
@@ -438,7 +439,6 @@
 		};
 
 		lptimer5: timer at 58003000 {
-			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32-lptimer";
 			reg = <0x58003000 0x400>;
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
index 45e088c55741..666b067e43b8 100644
--- a/arch/arm/boot/dts/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -53,7 +53,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at d0000000 {
 		reg = <0xd0000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 3f8e0c4a998d..caaa93b1bcc0 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -53,7 +53,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at d0000000 {
 		reg = <0xd0000000 0x2000000>;
 	};
 
-- 
1.9.1
