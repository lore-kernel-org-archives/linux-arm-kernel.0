From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:32:45 +0200
Subject: [PATCH 2/3] arm64: dts: mt8173: Use real clock for UARTs
In-Reply-To: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432128766-4445-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to use a fixed rate clock for the UARTs. Now that we have clock
support we can associate the correct clocks to the UARTs and drop the
26MHz fixed rate UART clock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index ef1d92f..02088a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -82,12 +82,6 @@
 		cpu_on	      = <0x84000003>;
 	};
 
-	uart_clk: dummy26m {
-		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
-		#clock-cells = <0>;
-	};
-
 	clk26m: oscillator at 0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -197,7 +191,8 @@
 					"mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -206,7 +201,8 @@
 					"mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x400>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -215,7 +211,8 @@
 					"mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x400>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 
@@ -224,7 +221,8 @@
 					"mediatek,mt6577-uart";
 			reg = <0 0x11005000 0 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
+			clock-names = "baud", "bus";
 			status = "disabled";
 		};
 	};
-- 
2.1.4
