From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:45 +0900
Subject: [PATCH 10/17] ARM: shmobile: r8a7790: Add SATA clocks to device tree
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <bccccc3d861567876a87441bc92f2e3b46cb38a9.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9e4202c..8cc68f7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -708,13 +708,16 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
+				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
-				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
+				R8A7790_CLK_SATA0
 			>;
-			clock-output-names = "vin3", "vin2", "vin1", "vin0", "ether";
+			clock-output-names =
+				"vin3", "vin2", "vin1", "vin0", "ether", "sata1", "sata0";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.8.5.2
