From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  5 May 2014 10:16:08 -0700
Subject: [PATCH] ARM: zynq: dt: Clean up device tree
Message-ID: <1399310168-6099-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Use generic node names
 - Fix up some weird formatting and white spaces
 - Update copyright info

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index c1176abc34d9..bed6e0aed00a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2011 Xilinx
+ *  Copyright (C) 2011 - 2014 Xilinx
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -55,7 +55,7 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
-		i2c0: zynq-i2c at e0004000 {
+		i2c0: i2c at e0004000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
 			clocks = <&clkc 38>;
@@ -66,7 +66,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: zynq-i2c at e0005000 {
+		i2c1: i2c at e0005000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
 			clocks = <&clkc 39>;
@@ -95,7 +95,7 @@
 			cache-level = <2>;
 		};
 
-		uart0: uart at e0000000 {
+		uart0: serial at e0000000 {
 			compatible = "xlnx,xuartps";
 			status = "disabled";
 			clocks = <&clkc 23>, <&clkc 40>;
@@ -104,7 +104,7 @@
 			interrupts = <0 27 4>;
 		};
 
-		uart1: uart at e0001000 {
+		uart1: serial at e0001000 {
 			compatible = "xlnx,xuartps";
 			status = "disabled";
 			clocks = <&clkc 24>, <&clkc 41>;
@@ -131,7 +131,7 @@
 			clock-names = "pclk", "hclk", "tx_clk";
 		};
 
-		sdhci0: ps7-sdhci at e0100000 {
+		sdhci0: sdhci at e0100000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
@@ -141,7 +141,7 @@
 			reg = <0xe0100000 0x1000>;
 		} ;
 
-		sdhci1: ps7-sdhci at e0101000 {
+		sdhci1: sdhci at e0101000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
@@ -185,26 +185,27 @@
 			clocks = <&clkc 4>;
 		};
 
-		ttc0: ttc0 at f8001000 {
+		ttc0: timer at f8001000 {
 			interrupt-parent = <&intc>;
-			interrupts = < 0 10 4 0 11 4 0 12 4 >;
+			interrupts = <0 10 4>, <0 11 4>, <0 12 4>;
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8001000 0x1000>;
 		};
 
-		ttc1: ttc1 at f8002000 {
+		ttc1: timer at f8002000 {
 			interrupt-parent = <&intc>;
-			interrupts = < 0 37 4 0 38 4 0 39 4 >;
+			interrupts = <0 37 4>, <0 38 4>, <0 39 4>;
 			compatible = "cdns,ttc";
 			clocks = <&clkc 6>;
 			reg = <0xF8002000 0x1000>;
 		};
-		scutimer: scutimer at f8f00600 {
+
+		scutimer: timer at f8f00600 {
 			interrupt-parent = <&intc>;
-			interrupts = < 1 13 0x301 >;
+			interrupts = <1 13 0x301>;
 			compatible = "arm,cortex-a9-twd-timer";
-			reg = < 0xf8f00600 0x20 >;
+			reg = <0xf8f00600 0x20>;
 			clocks = <&clkc 4>;
 		} ;
 	};
-- 
1.9.2.1.g06c4abd
