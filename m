From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:13 +0200
Subject: [PATCH 40/69] ARM: dts: r8a77470: Add SCIF support
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <8cdb8f1ab7efbd88868d3067ec1f211ff289bc01.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Describe SCIF ports in the R8A77470 device tree.
Also it fixes the CPG clock index ZS from 6 to 5.

Fixes: 6929dfc5918049 ("ARM: dts: r8a77470: Initial SoC device tree")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 69 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 2f89f33f5b88..39549f28be85 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -190,19 +190,84 @@
 			dma-channels = <15>;
 		};
 
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 0x40>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 721>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 721>;
+			status = "disabled";
+		};
+
 		scif1: serial at e6e68000 {
 			compatible = "renesas,scif-r8a77470",
 				     "renesas,rcar-gen2-scif", "renesas,scif";
 			reg = <0 0xe6e68000 0 0x40>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpg CPG_MOD 720>,
-				 <&cpg CPG_CORE 6>, <&scif_clk>;
+			clocks = <&cpg CPG_MOD 720>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			power-domains = <&sysc 32>;
 			resets = <&cpg 720>;
 			status = "disabled";
 		};
 
+		scif2: serial at e6e58000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6e58000 0 0x40>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 719>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 719>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6ea8000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ea8000 0 0x40>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 718>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 718>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6ee0000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ee0000 0 0x40>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 715>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 715>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6ee8000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ee8000 0 0x40>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 714>,
+				 <&cpg CPG_CORE 5>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 714>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.11.0
