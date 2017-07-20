From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 20 Jul 2017 16:17:05 +0200
Subject: [PATCH] ARM: dts: stm32: reorder stm32h743 nodes
Message-ID: <1500560225-31872-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder nodes to keep coherency with others platforms (stm32f4/stm32f7).
Nodes are ordered following base address.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 36a99db..343bf4a 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -59,13 +59,11 @@
 	};
 
 	soc {
-		usart1: serial at 40011000 {
-			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
-			reg = <0x40011000 0x400>;
-			interrupts = <37>;
-			status = "disabled";
+		timer5: timer at 40000c00 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000c00 0x400>;
+			interrupts = <50>;
 			clocks = <&timer_clk>;
-
 		};
 
 		usart2: serial at 40004400 {
@@ -76,11 +74,13 @@
 			clocks = <&timer_clk>;
 		};
 
-		timer5: timer at 40000c00 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000c00 0x400>;
-			interrupts = <50>;
+		usart1: serial at 40011000 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40011000 0x400>;
+			interrupts = <37>;
+			status = "disabled";
 			clocks = <&timer_clk>;
+
 		};
 	};
 };
-- 
2.7.4
