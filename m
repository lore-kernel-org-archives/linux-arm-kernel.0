From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 11 Jul 2017 08:56:16 +0200
Subject: [RESEND PATCH] ARM: dts: stm32: Add DMA support for STM32H743 SoC
Message-ID: <1499756176-540-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA support for STM32H743 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4685629..3d1cd88 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -74,6 +74,38 @@
 			interrupts = <50>;
 			clocks = <&timer_clk>;
 		};
+
+		dma1: dma at 40020000 {
+			compatible = "st,stm32-dma";
+			reg = <0x40020000 0x400>;
+			interrupts = <11>,
+				     <12>,
+				     <13>,
+				     <14>,
+				     <15>,
+				     <16>,
+				     <17>,
+				     <47>;
+			clocks = <&timer_clk>;
+			#dma-cells = <4>;
+			st,mem2mem;
+		};
+
+		dma2: dma at 40020400 {
+			compatible = "st,stm32-dma";
+			reg = <0x40020400 0x400>;
+			interrupts = <56>,
+				     <57>,
+				     <58>,
+				     <59>,
+				     <60>,
+				     <68>,
+				     <69>,
+				     <70>;
+			clocks = <&timer_clk>;
+			#dma-cells = <4>;
+			st,mem2mem;
+		};
 	};
 };
 
-- 
2.7.4
