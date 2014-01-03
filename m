From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  3 Jan 2014 16:01:49 +0800
Subject: [PATCH 4/6] arm: dts: sun6i: rename clock node names to clk@N
In-Reply-To: <1388736111-10103-1-git-send-email-wens@csie.org>
References: <1388736111-10103-1-git-send-email-wens@csie.org>
Message-ID: <1388736111-10103-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree naming conventions state that node names should match
node function. Change fully functioning clock nodes to match.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..a1f5193 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -60,17 +60,19 @@
 			clock-frequency = <24000000>;
 		};
 
-		osc32k: osc32k {
+		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
 		};
 
-		pll1: pll1 at 01c20000 {
+		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll1";
 		};
 
 		/*
@@ -120,7 +122,7 @@
 			clocks = <&ahb1_mux>;
 		};
 
-		ahb1_gates: ahb1_gates at 01c20060 {
+		ahb1_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-ahb1-gates-clk";
 			reg = <0x01c20060 0x8>;
@@ -148,7 +150,7 @@
 			clocks = <&ahb1>;
 		};
 
-		apb1_gates: apb1_gates at 01c20060 {
+		apb1_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-apb1-gates-clk";
 			reg = <0x01c20068 0x4>;
@@ -172,7 +174,7 @@
 			clocks = <&apb2_mux>;
 		};
 
-		apb2_gates: apb2_gates at 01c2006c {
+		apb2_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-apb2-gates-clk";
 			reg = <0x01c2006c 0x4>;
-- 
1.8.5.2
