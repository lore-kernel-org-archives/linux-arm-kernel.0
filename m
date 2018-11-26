From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:38 +0100
Subject: [PATCH 12/40] arm64: dts: renesas: r8a77990: Add SCIF-{0, 1, 3, 4,
 5} device nodes
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <a5ebe5e49a862e21c620656d2dc244a0d92833d9.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds the device nodes for SCIF-{0,1,3,4,5} serial ports to
the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 6d5efeb9f363..f969e680b9ba 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -679,6 +679,40 @@
 			status = "disabled";
 		};
 
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
+			       <&dmac2 0x51>, <&dmac2 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
+			       <&dmac2 0x53>, <&dmac2 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
+			status = "disabled";
+		};
+
 		scif2: serial at e6e88000 {
 			compatible = "renesas,scif-r8a77990",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
@@ -694,6 +728,55 @@
 			status = "disabled";
 		};
 
+		scif3: serial at e6c50000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6c40000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6f30000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>,
+				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
+			       <&dmac2 0x5b>, <&dmac2 0x5a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
+			status = "disabled";
+		};
+
 		msiof0: spi at e6e90000 {
 			compatible = "renesas,msiof-r8a77990",
 				     "renesas,rcar-gen3-msiof";
-- 
2.11.0
