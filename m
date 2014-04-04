From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 15:00:31 -0700
Subject: [PATCH 2/2] ARM: zynq: dt: Use #defines for interrupt specifiers
In-Reply-To: <1396648831-7570-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1396648831-7570-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1396648831-7570-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use #defines from the common include file to describe
interrupt specifiers.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

---
 arch/arm/boot/dts/zynq-7000.dtsi | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index b028278b7f49..a219a927c0e4 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -12,6 +12,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "xlnx,zynq-7000";
@@ -43,7 +44,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 5 4>, <0 6 4>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&intc>;
 		reg = < 0xf8891000 0x1000 0xf8893000 0x1000 >;
 	};
@@ -79,7 +80,7 @@
 			clocks = <&clkc 23>, <&clkc 40>;
 			clock-names = "ref_clk", "aper_clk";
 			reg = <0xE0000000 0x1000>;
-			interrupts = <0 27 4>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart1: uart at e0001000 {
@@ -88,14 +89,14 @@
 			clocks = <&clkc 24>, <&clkc 41>;
 			clock-names = "ref_clk", "aper_clk";
 			reg = <0xE0001000 0x1000>;
-			interrupts = <0 50 4>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		gem0: ethernet at e000b000 {
 			compatible = "cdns,gem";
 			reg = <0xe000b000 0x4000>;
 			status = "disabled";
-			interrupts = <0 22 4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkc 30>, <&clkc 30>, <&clkc 13>;
 			clock-names = "pclk", "hclk", "tx_clk";
 		};
@@ -104,7 +105,7 @@
 			compatible = "cdns,gem";
 			reg = <0xe000c000 0x4000>;
 			status = "disabled";
-			interrupts = <0 45 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkc 31>, <&clkc 31>, <&clkc 14>;
 			clock-names = "pclk", "hclk", "tx_clk";
 		};
@@ -115,7 +116,7 @@
 			clock-names = "clk_xin", "clk_ahb";
 			clocks = <&clkc 21>, <&clkc 32>;
 			interrupt-parent = <&intc>;
-			interrupts = <0 24 4>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xe0100000 0x1000>;
 		} ;
 
@@ -125,7 +126,7 @@
 			clock-names = "clk_xin", "clk_ahb";
 			clocks = <&clkc 22>, <&clkc 33>;
 			interrupt-parent = <&intc>;
-			interrupts = <0 47 4>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xe0101000 0x1000>;
 		} ;
 
@@ -159,14 +160,16 @@
 		global_timer: timer at f8f00200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0xf8f00200 0x20>;
-			interrupts = <1 11 0x301>;
+			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			interrupt-parent = <&intc>;
 			clocks = <&clkc 4>;
 		};
 
 		ttc0: ttc0 at f8001000 {
 			interrupt-parent = <&intc>;
-			interrupts = < 0 10 4 0 11 4 0 12 4 >;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8001000 0x1000>;
@@ -174,14 +177,16 @@
 
 		ttc1: ttc1 at f8002000 {
 			interrupt-parent = <&intc>;
-			interrupts = < 0 37 4 0 38 4 0 39 4 >;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8002000 0x1000>;
 		};
 		scutimer: scutimer at f8f00600 {
 			interrupt-parent = <&intc>;
-			interrupts = < 1 13 0x301 >;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = < 0xf8f00600 0x20 >;
 			clocks = <&clkc 4>;
-- 
1.9.1.1.gbb9f595
