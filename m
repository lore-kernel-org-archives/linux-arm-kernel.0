From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jul 2015 14:45:13 +0200
Subject: [PATCH 4/4] ARM: dts: mediatek mt8135: Use real UART clocks
In-Reply-To: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
References: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1436273113-25472-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to provide dummy clocks for the UART. Now that we have
common clock support we can provide the real clocks to the UART.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/mt8135.dtsi | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 36ff82a..08371db 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -90,12 +90,6 @@
 			#clock-cells = <0>;
 		};
 
-		uart_clk: dummy26m {
-			compatible = "fixed-clock";
-			clock-frequency = <26000000>;
-			#clock-cells = <0>;
-		};
-
 		clk26m: clk26m {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -209,7 +203,8 @@
 			compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
 			reg = <0 0x11006000 0 0x400>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -217,7 +212,8 @@
 			compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
 			reg = <0 0x11007000 0 0x400>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -225,7 +221,8 @@
 			compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
 			reg = <0 0x11008000 0 0x400>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -233,7 +230,8 @@
 			compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
 			reg = <0 0x11009000 0 0x400>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
-- 
2.1.4
