From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 01 Jun 2016 01:26:56 +0300
Subject: [PATCH 09/13] ARM: dts: r8a7792: add [H]SCIF support
In-Reply-To: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
Message-ID: <1493287.pGnW6U6caN@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe [H]SCIFs in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -140,6 +140,96 @@
 		dma-channels = <15>;
 	};
 
+	scif0: serial at e6e60000 {
+		compatible = "renesas,scif-r8a7792", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
+		reg = <0 0xe6e60000 0 64>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+		       <&dmac1 0x29>, <&dmac1 0x2a>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	scif1: serial at e6e68000 {
+		compatible = "renesas,scif-r8a7792", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
+		reg = <0 0xe6e68000 0 64>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+		       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	scif2: serial at e6e58000 {
+		compatible = "renesas,scif-r8a7792", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
+		reg = <0 0xe6e58000 0 64>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_SCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+		       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	scif3: serial at e6ea8000 {
+		compatible = "renesas,scif-r8a7792", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
+		reg = <0 0xe6ea8000 0 64>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_SCIF3>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+		       <&dmac1 0x2f>, <&dmac1 0x30>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7792", "renesas,rcar-gen2-hscif",
+			     "renesas,hscif";
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+		       <&dmac1 0x39>, <&dmac1 0x3a>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7792", "renesas,rcar-gen2-hscif",
+			     "renesas,hscif";
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7792_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+		       <&dmac1 0x4d>, <&dmac1 0x4e>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
