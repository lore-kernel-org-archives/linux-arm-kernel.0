From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Feb 2016 23:43:41 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7794: add EtherAVB clock
In-Reply-To: <1926986.gmrsfKE5A2@wasted.cogentembedded.com>
References: <1926986.gmrsfKE5A2@wasted.cogentembedded.com>
Message-ID: <29718029.UyjYgE2loj@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EtherAVB clock to the R8A7794 device tree.

Based on the commit eaa870b30553 ("ARM: shmobile: r8a7791: add EtherAVB clock").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi            |    7 ++++---
 include/dt-bindings/clock/r8a7794-clock.h |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -1173,13 +1173,14 @@
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
Index: renesas/include/dt-bindings/clock/r8a7794-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7794-clock.h
+++ renesas/include/dt-bindings/clock/r8a7794-clock.h
@@ -85,6 +85,7 @@
 /* MSTP8 */
 #define R8A7794_CLK_VIN1		10
 #define R8A7794_CLK_VIN0		11
+#define R8A7794_CLK_ETHERAVB		12
 #define R8A7794_CLK_ETHER		13
 
 /* MSTP9 */
