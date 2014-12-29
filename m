From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:44:00 +0900
Subject: [PATCH 29/30] ARM: shmobile: r8a7790: add MLB+ clock
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <f6b5dd4088d082b53eb135e1d6b4b213bf5ce127.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Add MLB+ clock to R8A7790 device tree.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
[Sergei: rebased, renamed, added changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 13 +++++++------
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ffeff98..af30c24 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1149,16 +1149,17 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
-				 <&zs_clk>, <&zs_clk>;
+			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
+			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
-				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
-				R8A7790_CLK_SATA0
+				R8A7790_CLK_MLB R8A7790_CLK_VIN3 R8A7790_CLK_VIN2
+				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+				R8A7790_CLK_SATA1 R8A7790_CLK_SATA0
 			>;
 			clock-output-names =
-				"vin3", "vin2", "vin1", "vin0", "ether", "sata1", "sata0";
+				"mlb", "vin3", "vin2", "vin1", "vin0", "ether",
+				"sata1", "sata0";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index c27b3b5..9194027 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -97,6 +97,7 @@
 #define R8A7790_CLK_LVDS0		26
 
 /* MSTP8 */
+#define R8A7790_CLK_MLB			2
 #define R8A7790_CLK_VIN3		8
 #define R8A7790_CLK_VIN2		9
 #define R8A7790_CLK_VIN1		10
-- 
2.1.3
