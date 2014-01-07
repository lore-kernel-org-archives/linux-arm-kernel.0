From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 11:06:53 +0900
Subject: [PATCH 1/2] Revert "ARM: shmobile: r8a7790: Add SSI clocks in device
 tree"
In-Reply-To: <cover.1389060068.git.horms+renesas@verge.net.au>
References: <cover.1389060068.git.horms+renesas@verge.net.au>
Message-ID: <4d0810257a7f1d040526a6dc5bde5a4737994a7e.1389060068.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 6dea2c1ebc6fc43852fd6125d75a75da223ff707.

Unfortunately this commit prevents multiplatform from booting to
the point where a serial console is available. Revert it while
a solution is sought.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 20 --------------------
 include/dt-bindings/clock/r8a7790-clock.h | 13 -------------
 2 files changed, 33 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c5417da..a179125 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -626,25 +626,5 @@
 			clock-output-names =
 				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
-		mstp10_clks: mstp10_clks at e6150998 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-			clocks = <&p_clk>, <&mstp10_clks R8A7790_CLK_SSI>,
-				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks R8A7790_CLK_SSI>,
-				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks R8A7790_CLK_SSI>,
-				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks R8A7790_CLK_SSI>,
-				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks R8A7790_CLK_SSI>,
-				 <&mstp10_clks R8A7790_CLK_SSI>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <
-				R8A7790_CLK_SSI R8A7790_CLK_SSI9 R8A7790_CLK_SSI8
-				R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
-				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2
-				R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
-			>;
-			clock-output-names =
-				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
-				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
-		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index dbb262a..859e9be 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -104,17 +104,4 @@
 #define R8A7790_CLK_I2C1		30
 #define R8A7790_CLK_I2C0		31
 
-/* MSTP10 */
-#define R8A7790_CLK_SSI			5
-#define R8A7790_CLK_SSI9		6
-#define R8A7790_CLK_SSI8		7
-#define R8A7790_CLK_SSI7		8
-#define R8A7790_CLK_SSI6		9
-#define R8A7790_CLK_SSI5		10
-#define R8A7790_CLK_SSI4		11
-#define R8A7790_CLK_SSI3		12
-#define R8A7790_CLK_SSI2		13
-#define R8A7790_CLK_SSI1		14
-#define R8A7790_CLK_SSI0		15
-
 #endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
1.8.4
