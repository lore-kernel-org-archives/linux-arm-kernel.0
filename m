From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 03 Aug 2015 14:38:01 -0700 (PDT)
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7794: add GPIO clocks
In-Reply-To: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
References: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
Message-ID: <4462688.4GuBmS2g6G@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the GPIO clocks in the R8A7794 device tree.

Based on the original patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
Changes in version 2:
- refreshed the patch;
- added Geert's and Laurent's ACKs.

 arch/arm/boot/dts/r8a7794.dtsi |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -720,16 +720,22 @@
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
