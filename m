From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 06 Oct 2016 00:41:33 +0300
Subject: [PATCH v3 06/11] ARM: dts: r8a7743: add [H]SCIF{A|B} support
In-Reply-To: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
Message-ID: <14213508.lp3q5ZvmbF@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe [H]SCIF[AB] ports in the R8A7743 device tree.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- resolved  a reject;
- updated the "clocks" properties for the CPG/MSSR driver;
- renamed the patch.

Changes in version 2:
- used  the new RZ/G family "compatible" prop values, reformatting where needed;
- fixed the size cells of the SCIFB device nodes' "reg" properties;
- changed the size cells of the "reg" properties to hexadecimal;
- indented the SCIFA1 device node's closing brace correctly
- adjusted the patch description, renamed the patch.

 arch/arm/boot/dts/r8a7743.dtsi |  261 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
+++ renesas/arch/arm/boot/dts/r8a7743.dtsi
@@ -162,6 +162,267 @@
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
+
+		scifa0: serial at e6c40000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c40000 0 0x40>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x21>, <&dmac0 0x22>,
+			       <&dmac1 0x21>, <&dmac1 0x22>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifa1: serial at e6c50000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c50000 0 0x40>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x25>, <&dmac0 0x26>,
+			       <&dmac1 0x25>, <&dmac1 0x26>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifa2: serial at e6c60000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c60000 0 0x40>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x27>, <&dmac0 0x28>,
+			       <&dmac1 0x27>, <&dmac1 0x28>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifa3: serial at e6c70000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c70000 0 0x40>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1106>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
+			       <&dmac1 0x1b>, <&dmac1 0x1c>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifa4: serial at e6c78000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c78000 0 0x40>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1107>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
+			       <&dmac1 0x1f>, <&dmac1 0x20>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifa5: serial at e6c80000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c80000 0 0x40>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1108>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x23>, <&dmac0 0x24>,
+			       <&dmac1 0x23>, <&dmac1 0x24>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifb0: serial at e6c20000 {
+			compatible = "renesas,scifb-r8a7743",
+				     "renesas,rzg-scifb", "renesas,scifb";
+			reg = <0 0xe6c20000 0 0x100>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifb1: serial at e6c30000 {
+			compatible = "renesas,scifb-r8a7743",
+				     "renesas,rzg-scifb", "renesas,scifb";
+			reg = <0 0xe6c30000 0 0x100>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+			       <&dmac1 0x19>, <&dmac1 0x1a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scifb2: serial at e6ce0000 {
+			compatible = "renesas,scifb-r8a7743",
+				     "renesas,rzg-scifb", "renesas,scifb";
+			reg = <0 0xe6ce0000 0 0x100>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 216>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+			       <&dmac1 0x1d>, <&dmac1 0x1e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e60000 0 0x40>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 721>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+			       <&dmac1 0x29>, <&dmac1 0x2a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e68000 0 0x40>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 720>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+			       <&dmac1 0x2d>, <&dmac1 0x2e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif2: serial at e6e58000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e58000 0 0x40>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 719>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+			       <&dmac1 0x2b>, <&dmac1 0x2c>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6ea8000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6ea8000 0 0x40>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 718>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+			       <&dmac1 0x2f>, <&dmac1 0x30>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6ee0000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6ee0000 0 0x40>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 715>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+			       <&dmac1 0xfb>, <&dmac1 0xfc>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6ee8000 {
+			compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",
+				     "renesas,scif";
+			reg = <0 0xe6ee8000 0 0x40>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 714>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+			       <&dmac1 0xfd>, <&dmac1 0xfe>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		hscif0: serial at e62c0000 {
+			compatible = "renesas,hscif-r8a7743",
+				     "renesas,rzg-hscif", "renesas,hscif";
+			reg = <0 0xe62c0000 0 0x60>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 717>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+			       <&dmac1 0x39>, <&dmac1 0x3a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		hscif1: serial at e62c8000 {
+			compatible = "renesas,hscif-r8a7743",
+				     "renesas,rzg-hscif", "renesas,hscif";
+			reg = <0 0xe62c8000 0 0x60>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+			       <&dmac1 0x4d>, <&dmac1 0x4e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		hscif2: serial at e62d0000 {
+			compatible = "renesas,hscif-r8a7743",
+				     "renesas,rzg-hscif", "renesas,hscif";
+			reg = <0 0xe62d0000 0 0x60>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 713>,
+			         <&cpg CPG_CORE R8A7743_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
+			       <&dmac1 0x3b>, <&dmac1 0x3c>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
