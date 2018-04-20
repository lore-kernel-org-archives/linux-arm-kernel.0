From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:14:40 +0200
Subject: [PATCH v1 3/4] ARM: dts: stm32: Add DMAv2 support on STM32MP157C
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215681-14555-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Activate DMAv2 for STM32MP157C

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..3c0ca6c 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -160,6 +160,38 @@
 			status = "disabled";
 		};
 
+		dma1: dma at 48000000 {
+			compatible = "st,stm32-dma";
+			reg = <0x48000000 0x400>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc DMA1>;
+			#dma-cells = <4>;
+			st,mem2mem;
+		};
+
+		dma2: dma at 48001000 {
+			compatible = "st,stm32-dma";
+			reg = <0x48001000 0x400>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc DMA2>;
+			#dma-cells = <4>;
+			st,mem2mem;
+		};
+
 		rcc: rcc at 50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.7.4
