From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 15:23:54 +0200
Subject: [PATCH] ARM: dts: stm32: Fix IRQ_TYPE_NONE warnings on stm32mp157c
Message-ID: <1525267434-12644-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about
the use of IRQ_TYPE_NONE"), a warning is raised if IRQ_TYPE_NONE is used.
So we use IRQ_TYPE_LEVEL_HIGH for usart nodes instead of IRQ_TYPE_NONE.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9c1a6c4..d096d06 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -314,7 +314,7 @@
 		usart2: serial at 4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART2_K>;
 			status = "disabled";
 		};
@@ -322,7 +322,7 @@
 		usart3: serial at 4000f000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000f000 0x400>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART3_K>;
 			status = "disabled";
 		};
@@ -330,7 +330,7 @@
 		uart4: serial at 40010000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART4_K>;
 			status = "disabled";
 		};
@@ -338,7 +338,7 @@
 		uart5: serial at 40011000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
-			interrupts = <GIC_SPI 53 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART5_K>;
 			status = "disabled";
 		};
@@ -370,7 +370,7 @@
 		uart7: serial at 40018000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
-			interrupts = <GIC_SPI 82 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART7_K>;
 			status = "disabled";
 		};
@@ -378,7 +378,7 @@
 		uart8: serial at 40019000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40019000 0x400>;
-			interrupts = <GIC_SPI 83 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART8_K>;
 			status = "disabled";
 		};
@@ -428,7 +428,7 @@
 		usart6: serial at 44003000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x44003000 0x400>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART6_K>;
 			status = "disabled";
 		};
@@ -591,7 +591,7 @@
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
-- 
2.7.4
