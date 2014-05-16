From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:18 +0900
Subject: [PATCH 09/11] ARM: shmobile: r8a7791 dtsi: Add GPIO clocks
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <4faf9c5e56d1326067f5faca551eb67ecf76696c.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f4d47e1..5eea08f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -76,6 +76,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO0>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -87,6 +88,7 @@
 		gpio-ranges = <&pfc 0 32 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO1>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -98,6 +100,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO2>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -109,6 +112,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO3>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -120,6 +124,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO4>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -131,6 +136,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
 	};
 
 	gpio6: gpio at e6055400 {
@@ -142,6 +148,7 @@
 		gpio-ranges = <&pfc 0 192 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
 	};
 
 	gpio7: gpio at e6055800 {
@@ -153,6 +160,7 @@
 		gpio-ranges = <&pfc 0 224 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		clocks = <&mstp9_clks R8A7791_CLK_GPIO7>;
 	};
 
 	thermal at e61f0000 {
@@ -802,18 +810,23 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&hp_clk>,
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&hp_clk>,
 				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
 				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
+				R8A7791_CLK_GPIO7 R8A7791_CLK_GPIO6 R8A7791_CLK_GPIO5 R8A7791_CLK_GPIO4
+				R8A7791_CLK_GPIO3 R8A7791_CLK_GPIO2 R8A7791_CLK_GPIO1 R8A7791_CLK_GPIO0
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
 				R8A7791_CLK_IICDVFS R8A7791_CLK_I2C4 R8A7791_CLK_I2C3 R8A7791_CLK_I2C2
 				R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
 			>;
 			clock-output-names =
-				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c6", "i2c4", "i2c3",
-				"i2c2", "i2c1", "i2c0";
+				"gpio7", "gpio6", "gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
+				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c6", "i2c4", "i2c3", "i2c2",
+				"i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.8.5.2
