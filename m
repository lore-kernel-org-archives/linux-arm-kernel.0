From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:27 +0900
Subject: [PATCH 01/29] ARM: shmobile: r8a7794: Add VIN clock to device tree
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <148ebf479aa207406f8208466b3e446f9cd25f4b.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 6 +++---
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 088e79c..95f656d 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -517,13 +517,13 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&p_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7794_CLK_ETHER
+				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0 R8A7794_CLK_ETHER
 			>;
 			clock-output-names =
-				"ether";
+				"vin1", "vin0", "ether";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 9ac1043..fd7cdee 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -61,6 +61,8 @@
 #define R8A7794_CLK_SCIF0		21
 
 /* MSTP8 */
+#define R8A7794_CLK_VIN1		10
+#define R8A7794_CLK_VIN0		11
 #define R8A7794_CLK_ETHER		13
 
 /* MSTP9 */
-- 
2.1.1
