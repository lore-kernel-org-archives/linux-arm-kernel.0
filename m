From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:05 +0900
Subject: [PATCH 16/19] ARM: dts: r8a7794: add EtherAVB clock
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <255a40424e2618610a2ad8d39e12b843b723959a.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the EtherAVB clock to the R8A7794 device tree.

Based on the commit eaa870b30553 ("ARM: shmobile: r8a7791: add EtherAVB
clock").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 21a02df3609b..042440b6dc8c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1112,13 +1112,14 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&p_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&hp_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0 R8A7794_CLK_ETHER
+				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0
+				R8A7794_CLK_ETHERAVB R8A7794_CLK_ETHER
 			>;
 			clock-output-names =
-				"vin1", "vin0", "ether";
+				"vin1", "vin0", "etheravb", "ether";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index a7a7e0370968..f843de6bf377 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -84,6 +84,7 @@
 /* MSTP8 */
 #define R8A7794_CLK_VIN1		10
 #define R8A7794_CLK_VIN0		11
+#define R8A7794_CLK_ETHERAVB		12
 #define R8A7794_CLK_ETHER		13
 
 /* MSTP9 */
-- 
2.7.0.rc3.207.g0ac5344
