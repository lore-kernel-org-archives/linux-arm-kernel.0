From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 11:06:54 +0900
Subject: [PATCH 2/2] Revert "ARM: shmobile: r8a7791: Add SSI clocks in device
 tree"
In-Reply-To: <cover.1389060068.git.horms+renesas@verge.net.au>
References: <cover.1389060068.git.horms+renesas@verge.net.au>
Message-ID: <3effae8c26f451a9d572255c08dfbe342dd1dc98.1389060068.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b652896b02df3dfde3a68957cce01f2aa4585842.

Unfortunately this commit prevents multiplatform from booting to
the point where a serial console is available. Revert it while
a solution is sought.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 20 --------------------
 include/dt-bindings/clock/r8a7791-clock.h | 13 -------------
 2 files changed, 33 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e92c1f7..19c6550 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -495,26 +495,6 @@
 				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
 				"i2c2", "i2c1", "i2c0";
 		};
-		mstp10_clks: mstp10_clks at e6150998 {
-			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-			clocks = <&p_clk>, <&mstp10_clks R8A7791_CLK_SSI>,
-				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
-				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
-				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
-				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
-				 <&mstp10_clks R8A7791_CLK_SSI>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <
-				R8A7791_CLK_SSI R8A7791_CLK_SSI9 R8A7791_CLK_SSI8
-				R8A7791_CLK_SSI7 R8A7791_CLK_SSI6 R8A7791_CLK_SSI5
-				R8A7791_CLK_SSI4 R8A7791_CLK_SSI3 R8A7791_CLK_SSI2
-				R8A7791_CLK_SSI1 R8A7791_CLK_SSI0
-			>;
-			clock-output-names =
-				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
-				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
-		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 1c8f00d..30f82f2 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -103,19 +103,6 @@
 #define R8A7791_CLK_I2C1		30
 #define R8A7791_CLK_I2C0		31
 
-/* MSTP10 */
-#define R8A7791_CLK_SSI			5
-#define R8A7791_CLK_SSI9		6
-#define R8A7791_CLK_SSI8		7
-#define R8A7791_CLK_SSI7		8
-#define R8A7791_CLK_SSI6		9
-#define R8A7791_CLK_SSI5		10
-#define R8A7791_CLK_SSI4		11
-#define R8A7791_CLK_SSI3		12
-#define R8A7791_CLK_SSI2		13
-#define R8A7791_CLK_SSI1		14
-#define R8A7791_CLK_SSI0		15
-
 /* MSTP11 */
 #define R8A7791_CLK_SCIFA3		6
 #define R8A7791_CLK_SCIFA4		7
-- 
1.8.4
