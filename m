From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:23:55 +0900
Subject: [PATCH 04/12] ARM: shmobile: r8a7790: Add DMAC clocks to DT
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <c819acdab3bf02795db6d16a17426e21c99c3c28.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the SYS-DMAC0 and SYS-DMAC1 clocks to the MSTP2 clock node. They
will be used by the upcoming DMAC DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d9ddecb..220662f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -758,16 +758,19 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>,
+				 <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
+				R8A7790_CLK_SYS_DMAC1 R8A7790_CLK_SYS_DMAC0
 			>;
 			clock-output-names =
 				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "msiof3", "scifb2";
+				"scifb1", "msiof1", "msiof3", "scifb2",
+				"sys-dmac1", "sys-dmac0";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
2.0.1
