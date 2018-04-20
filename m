From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:05:21 +0200
Subject: [PATCH v1 1/2] ARM: dts: stm32: Add I2C support for STM32H743 SoC
In-Reply-To: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215122-14046-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support for STM32H743 SoC

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 0f15dfb..24be8e6 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -163,6 +163,16 @@
 				#interrupt-cells = <2>;
 			};
 
+			i2c1_pins_a: i2c1 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
+						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
 			usart1_pins: usart1 at 0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 2bb103e..7b64af0 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -130,6 +130,42 @@
 			clocks = <&rcc USART2_CK>;
 		};
 
+		i2c1: i2c at 40005400 {
+			compatible = "st,stm32f7-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc STM32H7_APB1L_RESET(I2C1)>;
+			clocks = <&rcc I2C1_CK>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 40005800 {
+			compatible = "st,stm32f7-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x40005800 0x400>;
+			interrupts = <33>,
+				     <34>;
+			resets = <&rcc STM32H7_APB1L_RESET(I2C2)>;
+			clocks = <&rcc I2C2_CK>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 40005C00 {
+			compatible = "st,stm32f7-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x40005C00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32H7_APB1L_RESET(I2C3)>;
+			clocks = <&rcc I2C3_CK>;
+			status = "disabled";
+		};
+
 		dac: dac at 40007400 {
 			compatible = "st,stm32h7-dac-core";
 			reg = <0x40007400 0x400>;
@@ -323,6 +359,18 @@
 			status = "disabled";
 		};
 
+		i2c4: i2c at 58001C00 {
+			compatible = "st,stm32f7-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x58001C00 0x400>;
+			interrupts = <95>,
+				     <96>;
+			resets = <&rcc STM32H7_APB4_RESET(I2C4)>;
+			clocks = <&rcc I2C4_CK>;
+			status = "disabled";
+		};
+
 		lptimer2: timer at 58002400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
