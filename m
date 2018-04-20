From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:05:08 +0200
Subject: [PATCH v1 1/3] ARM: dts: stm32: Append additional I2Cs for STM32F746
 SoC
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215110-13967-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append 3 additional I2C instance for STM32F746 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32f746.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 4be2ee5..1479e3e 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -345,6 +345,42 @@
 			status = "disabled";
 		};
 
+		i2c2: i2c at 40005800 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005800 0x400>;
+			interrupts = <33>,
+				     <34>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C2)>;
+			clocks = <&rcc 1 CLK_I2C2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 40005C00 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005C00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C3)>;
+			clocks = <&rcc 1 CLK_I2C3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at 40006000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40006000 0x400>;
+			interrupts = <95>,
+				     <96>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C4)>;
+			clocks = <&rcc 1 CLK_I2C4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cec: cec at 40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.7.4
