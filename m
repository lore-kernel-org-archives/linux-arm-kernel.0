From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:43 +0200
Subject: [PATCH 10/69] ARM: dts: renesas: r8a7791: Add FDP1 instances
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <e7f36fb8ffafbda9c168e1aafab5b5ebe54ebaa8.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7791 has two FDP1 instances.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f11dab71b03a..55b5a56da35e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1621,6 +1621,24 @@
 			resets = <&cpg 127>;
 		};
 
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+			resets = <&cpg 119>;
+		};
+
+		fdp1 at fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+			resets = <&cpg 118>;
+		};
+
 		jpu: jpeg-codec at fe980000 {
 			compatible = "renesas,jpu-r8a7791",
 				     "renesas,rcar-gen2-jpu";
-- 
2.11.0
