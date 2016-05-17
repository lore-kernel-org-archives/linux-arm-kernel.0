From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 17 May 2016 13:05:11 +0800
Subject: [PATCH v8 10/10] arm: dts: mt2701: Use real clock for UARTs
In-Reply-To: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
References: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1463461511-25019-11-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to use a fixed rate clock for the UARTs. Now that we have clock
support we can associate the correct clocks to the UARTs and drop the
26MHz fixed rate UART clock.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 171d4da..e79e88f 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -71,12 +71,6 @@
 		#clock-cells = <0>;
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
@@ -167,7 +161,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11002000 0 0x400>;
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
+		clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
+		clock-names = "baud", "bus";
 		status = "disabled";
 	};
 
@@ -176,7 +171,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11003000 0 0x400>;
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
+		clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
+		clock-names = "baud", "bus";
 		status = "disabled";
 	};
 
@@ -185,7 +181,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11004000 0 0x400>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
+		clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
+		clock-names = "baud", "bus";
 		status = "disabled";
 	};
 
@@ -194,7 +191,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11005000 0 0x400>;
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
+		clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
+		clock-names = "baud", "bus";
 		status = "disabled";
 	};
 };
-- 
1.9.1
