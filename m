From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 29 Sep 2017 11:37:48 +0200
Subject: [PATCH v2] ARM: dts: stm32: Add DMAMUX support for STM32H743 SoC
Message-ID: <1506677868-16039-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAMUX support for STM32H743 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v2:
       * Update DTS to be compliant with up-streamed bindings
    v1:
       * Initial
---
---
 arch/arm/boot/dts/stm32h743.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index c8e1137..ee29bbe 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -207,6 +207,7 @@
 				     <47>;
 			clocks = <&timer_clk>;
 			#dma-cells = <4>;
+			dma-requests = <8>;
 			st,mem2mem;
 		};
 
@@ -223,9 +224,20 @@
 				     <70>;
 			clocks = <&timer_clk>;
 			#dma-cells = <4>;
+			dma-requests = <8>;
 			st,mem2mem;
 		};
 
+		dmamux1: dma-router at 40020800 {
+			compatible = "st,stm32h7-dmamux";
+			reg = <0x40020800 0x1c>;
+			#dma-cells = <3>;
+			dma-channels = <16>;
+			dma-requests = <128>;
+			dma-masters = <&dma1 &dma2>;
+			clocks = <&timer_clk>;
+		};
+
 		mdma1: dma at 52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
-- 
2.7.4
