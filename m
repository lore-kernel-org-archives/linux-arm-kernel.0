From: lars.persson@axis.com (Lars Persson)
Date: Tue, 23 Aug 2016 16:00:50 +0200
Subject: [PATCH 1/3] ARM: dts: artpec: use clock binding header
In-Reply-To: <cover.1471959733.git.larper@axis.com>
References: <cover.1471959733.git.larper@axis.com>
Message-ID: <a2b9724cc9324315c5cef65130a7a8ef0d6b20ce.1471959733.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use defines from the clock binding header as clock indexes.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 3fac4c4..db41b52 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -41,6 +41,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axis,artpec6-clkctrl.h>
 #include "skeleton.dtsi"
 
 / {
@@ -109,14 +110,14 @@
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0xfaf00200 0x20>;
 		interrupts = <GIC_PPI 11 0xf01>;
-		clocks = <&clkctrl 1>;
+		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
 	};
 
 	timer at faf00600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xfaf00600 0x20>;
 		interrupts = <GIC_PPI 13 0xf04>;
-		clocks = <&clkctrl 1>;
+		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
 		status = "disabled";
 	};
 
@@ -157,7 +158,7 @@
 		ethernet: ethernet at f8010000 {
 			clock-names = "phy_ref_clk", "apb_pclk";
 			clocks = <&eth_phy_ref_clk>,
-				<&clkctrl 4>;
+				<&clkctrl ARTPEC6_CLK_ETH_ACLK>;
 			compatible = "snps,dwc-qos-ethernet-4.10";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -175,8 +176,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8036000 0x1000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkctrl 13>,
-				<&clkctrl 12>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -184,8 +185,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8037000 0x1000>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkctrl 13>,
-				<&clkctrl 12>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -193,8 +194,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8038000 0x1000>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkctrl 13>,
-				<&clkctrl 12>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
@@ -202,8 +203,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8039000 0x1000>;
 			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkctrl 13>,
-				<&clkctrl 12>;
+			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
+				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			status = "disabled";
 		};
-- 
2.1.4
