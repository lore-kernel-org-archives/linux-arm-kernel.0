From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:15 +0200
Subject: [PATCH 42/69] ARM: dts: renesas: r8a7790: Add FDP1 instances
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <5d3b50d3c04dc277258dfca02afdddd8e69ecd29.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7790 has three FDP1 instances.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7ba62b7aa0ba..0f1948d560d7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1616,6 +1616,33 @@
 			resets = <&cpg 128>;
 		};
 
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 119>;
+		};
+
+		fdp1 at fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 118>;
+		};
+
+		fdp1 at fe948000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe948000 0 0x2400>;
+			interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 117>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 117>;
+		};
+
 		vsp at fe938000 {
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe938000 0 0x8000>;
-- 
2.11.0
