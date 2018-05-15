From: erwan.leray@st.com (Erwan Le Ray)
Date: Tue, 15 May 2018 14:23:58 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: m_can support to stm32mp157c
In-Reply-To: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
References: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
Message-ID: <1526387039-14813-2-git-send-email-erwan.leray@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Controller Area Network m_can to STM32MP157C SoC.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..12ac73f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -556,6 +556,32 @@
 			};
 		};
 
+		m_can1: can at 4400e000 {
+			compatible = "bosch,m_can";
+			reg = <0x4400e000 0x400>, <0x44011000 0x2800>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+			clock-names = "hclk", "cclk";
+			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+			status = "disabled";
+		};
+
+		m_can2: can at 4400f000 {
+			compatible = "bosch,m_can";
+			reg = <0x4400f000 0x400>, <0x44011000 0x2800>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+			clock-names = "hclk", "cclk";
+			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+			status = "disabled";
+		};
+
 		dma1: dma at 48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
-- 
1.9.1
