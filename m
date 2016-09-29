From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Sep 2016 01:28:30 +0300
Subject: [PATCH RFC v2 7/12] ARM: dts: r8a7743: add [H]SCIF[AB] support
In-Reply-To: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
References: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
Message-ID: <4510241.8TZ1egobB9@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe [H]SCIF[AB] ports in the R8A7743 device tree.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
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
@@ -154,6 +154,267 @@
 			dma-channels = <15>;
 		};
 
+		scifa0: serial at e6c40000 {
+			compatible = "renesas,scifa-r8a7743",
+				     "renesas,rzg-scifa", "renesas,scifa";
+			reg = <0 0xe6c40000 0 0x40>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFA0>;
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
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFA1>;
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
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFA2>;
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
+			clocks = <&mstp11_clks R8A7743_CLK_SCIFA3>;
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
+			clocks = <&mstp11_clks R8A7743_CLK_SCIFA4>;
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
+			clocks = <&mstp11_clks R8A7743_CLK_SCIFA5>;
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
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFB0>;
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
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFB1>;
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
+			clocks = <&mstp2_clks R8A7743_CLK_SCIFB2>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF0>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF1>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF2>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF3>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF4>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_SCIF5>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_HSCIF0>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_HSCIF1>, <&zs_clk>,
+				 <&scif_clk>;
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
+			clocks = <&mstp7_clks R8A7743_CLK_HSCIF2>, <&zs_clk>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
+			       <&dmac1 0x3b>, <&dmac1 0x3c>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7743-cpg-clocks",
