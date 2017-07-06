From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 6 Jul 2017 15:23:08 +0200
Subject: [PATCH] ARM: dts: stm32: Add DMAMUX support for STM32H743 SoC
Message-ID: <1499347388-8363-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAMUX support for STM32H743 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 3d1cd88..0e24a4c 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -106,6 +106,26 @@
 			#dma-cells = <4>;
 			st,mem2mem;
 		};
+
+		dmamux1: dma-router at 40020800 {
+			compatible = "st,stm32h7-dmamux";
+			reg = <0x40020800 0x1c>;
+			#dma-cells = <3>;
+			dma-channels = <8>;
+			dma-requests = <128>;
+			dma-masters = <&dma1>;
+			clocks = <&timer_clk>;
+		};
+
+		dmamux2: dma-router at 40020820 {
+			compatible = "st,stm32h7-dmamux";
+			reg = <0x40020820 0x1c>;
+			#dma-cells = <3>;
+			dma-channels = <8>;
+			dma-requests = <128>;
+			dma-masters = <&dma2>;
+			clocks = <&timer_clk>;
+		};
 	};
 };
 
-- 
2.7.4
