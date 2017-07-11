From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 11 Jul 2017 08:54:27 +0200
Subject: [RESEND PATCH] ARM: dts: stm32: Add DMA support for STM32F746 SoC
Message-ID: <1499756067-445-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA support for STM32F746 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index c2765ce..bfffea4 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -344,6 +344,37 @@
 			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
 			assigned-clock-rates = <1000000>;
 		};
+
+		dma1: dma at 40026000 {
+			compatible = "st,stm32-dma";
+			reg = <0x40026000 0x400>;
+			interrupts = <11>,
+				     <12>,
+				     <13>,
+				     <14>,
+				     <15>,
+				     <16>,
+				     <17>,
+				     <47>;
+			clocks = <&rcc 0 21>;
+			#dma-cells = <4>;
+		};
+
+		dma2: dma at 40026400 {
+			compatible = "st,stm32-dma";
+			reg = <0x40026400 0x400>;
+			interrupts = <56>,
+				     <57>,
+				     <58>,
+				     <59>,
+				     <60>,
+				     <68>,
+				     <69>,
+				     <70>;
+			clocks = <&rcc 0 22>;
+			#dma-cells = <4>;
+			st,mem2mem;
+		};
 	};
 };
 
-- 
2.7.4
