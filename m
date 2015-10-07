From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:57:39 +0900
Subject: [PATCH 02/28] ARM: shmobile: r8a7794: add GPIO clocks
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <3f37e01852a06faf1d5fed30eaee5cae942fc9d5.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the GPIO clocks in the R8A7794 device tree.

Based on the original patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 97c8e9ace5eb..b6db773b9e55 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -749,16 +749,22 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cpg_clocks R8A7794_CLK_QSPI>, <&hp_clk>, <&hp_clk>,
-				<&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cpg_clocks R8A7794_CLK_QSPI>, <&hp_clk>, <&hp_clk>,
+				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_QSPI_MOD R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
-				R8A7794_CLK_I2C3 R8A7794_CLK_I2C2 R8A7794_CLK_I2C1
-				R8A7794_CLK_I2C0
-			>;
+			clock-indices = <R8A7794_CLK_GPIO6 R8A7794_CLK_GPIO5
+					 R8A7794_CLK_GPIO4 R8A7794_CLK_GPIO3
+					 R8A7794_CLK_GPIO2 R8A7794_CLK_GPIO1
+					 R8A7794_CLK_GPIO0 R8A7794_CLK_QSPI_MOD
+					 R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
+					 R8A7794_CLK_I2C3 R8A7794_CLK_I2C2
+					 R8A7794_CLK_I2C1 R8A7794_CLK_I2C0>;
 			clock-output-names =
-				"qspi_mod", "i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
+				"gpio6", "gpio5", "gpio4", "gpio3", "gpio2",
+				"gpio1", "gpio0", "qspi_mod",
+				"i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
2.1.4
