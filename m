From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:43 +0900
Subject: [PATCH 08/17] ARM: shmobile: r8a7790: Add VIN clocks to device tree
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <3f2beaa9f2d7229c041975e40868dee2e3c4a598.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 15e2a97..9e4202c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -708,10 +708,13 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&p_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_ETHER>;
-			clock-output-names = "ether";
+			renesas,clock-indices = <
+				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
+				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+			>;
+			clock-output-names = "vin3", "vin2", "vin1", "vin0", "ether";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.8.5.2
