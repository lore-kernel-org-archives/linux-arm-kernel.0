From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:18 +0200
Subject: [PATCH 45/69] ARM: dts: r8a7790: Fix sort order of VSP1/FDP1 nodes
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <b9ac80c815eabb81b66dc2dad2bb1a376915aeca.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Commit 5d3b50d3c04d ("ARM: dts: renesas: r8a7790: Add FDP1 instances")
introduced the FDP1 for the r8a7790, but broke the sort ordering of the
device tree nodes.

Move the last VSP up to it's peers to correct the ordering.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0f1948d560d7..b64d99e3ad9d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1616,6 +1616,15 @@
 			resets = <&cpg 128>;
 		};
 
+		vsp at fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 127>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 127>;
+		};
+
 		fdp1 at fe940000 {
 			compatible = "renesas,fdp1";
 			reg = <0 0xfe940000 0 0x2400>;
@@ -1643,15 +1652,6 @@
 			resets = <&cpg 117>;
 		};
 
-		vsp at fe938000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe938000 0 0x8000>;
-			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 127>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 127>;
-		};
-
 		jpu: jpeg-codec at fe980000 {
 			compatible = "renesas,jpu-r8a7790",
 				     "renesas,rcar-gen2-jpu";
-- 
2.11.0
