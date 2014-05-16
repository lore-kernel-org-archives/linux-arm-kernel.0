From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:17 +0900
Subject: [PATCH 08/11] ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <81f6883f0b1bbb1dbca34cc65257f823acb55cbd.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index bf2db38..e6130d6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -117,6 +117,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -128,6 +129,7 @@
 		gpio-ranges = <&pfc 0 32 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -139,6 +141,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -150,6 +153,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -161,6 +165,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -172,6 +177,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
 	};
 
 	thermal at e61f0000 {
@@ -802,14 +808,19 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
 				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
+				R8A7790_CLK_GPIO5 R8A7790_CLK_GPIO4 R8A7790_CLK_GPIO3
+				R8A7790_CLK_GPIO2 R8A7790_CLK_GPIO1 R8A7790_CLK_GPIO0
 				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD R8A7790_CLK_IICDVFS
 				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
 			>;
 			clock-output-names =
+				"gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
 				"rcan1", "rcan0", "qspi_mod", "iic3",
 				"i2c3", "i2c2", "i2c1", "i2c0";
 		};
-- 
1.8.5.2
