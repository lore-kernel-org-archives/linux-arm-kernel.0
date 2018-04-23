From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Mon, 23 Apr 2018 11:48:28 +0200
Subject: [PATCH v2 2/5] ARM: dts: stm32: Add STM32F7 I2C support for
 STM32MP157C SoC
In-Reply-To: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524476911-19056-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds all STM32F7 I2C instances for STM32MP157C SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
     v2:
        * Disambiguate subject
---
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..9e94186 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -136,6 +136,57 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c at 40012000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40012000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C1_K>;
+			resets = <&rcc I2C1_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 40013000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40013000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C2_K>;
+			resets = <&rcc I2C2_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 40014000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40014000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C3_K>;
+			resets = <&rcc I2C3_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5: i2c at 40015000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40015000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C5_K>;
+			resets = <&rcc I2C5_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart7: serial at 40018000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
@@ -174,5 +225,31 @@
 			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
+
+		i2c4: i2c at 5c002000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x5c002000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C4_K>;
+			resets = <&rcc I2C4_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c at 5c009000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x5c009000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C6_K>;
+			resets = <&rcc I2C6_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
