From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Sep 2017 23:37:23 +0300
Subject: [PATCH 07/11] arm64: dts: renesas: r8a77970: add [H]SCIF support
Message-ID: <20170912210531.451036685@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe [H]SCIF ports in the R8A77970 device tree.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |  141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -60,6 +60,13 @@
 		clock-frequency = <0>;
 	};
 
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -170,5 +177,139 @@
 			#dma-cells = <1>;
 			dma-channels = <8>;
 		};
+
+		hscif0: serial at e6540000 {
+			compatible = "renesas,hscif-r8a77970",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6540000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 520>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 520>;
+			status = "disabled";
+		};
+
+		hscif1: serial at e6550000 {
+			compatible = "renesas,hscif-r8a77970",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6550000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 519>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 519>;
+			status = "disabled";
+		};
+
+		hscif2: serial at e6560000 {
+			compatible = "renesas,hscif-r8a77970",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6560000 0 96>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 518>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 518>;
+			status = "disabled";
+		};
+
+		hscif3: serial at e66a0000 {
+			compatible = "renesas,hscif-r8a77970",
+				     "renesas,rcar-gen3-hscif", "renesas,hscif";
+			reg = <0 0xe66a0000 0 96>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 517>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x37>, <&dmac1 0x36>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
+			status = "disabled";
+		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a77970",
+				     "renesas,rcar-gen3-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a77970",
+				     "renesas,rcar-gen3-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6c50000 {
+			compatible = "renesas,scif-r8a77970",
+				     "renesas,rcar-gen3-scif",
+				     "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x57>, <&dmac1 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6c40000 {
+			compatible = "renesas,scif-r8a77970",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>,
+				 <&cpg CPG_CORE 9>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x59>, <&dmac1 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
+			status = "disabled";
+		};
 	};
 };
