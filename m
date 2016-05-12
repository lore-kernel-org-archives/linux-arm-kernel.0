From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Thu, 12 May 2016 10:54:45 +0200
Subject: [PATCHv4 4/4] ARM: dts: r8a7794: Reference both DMA controllers
In-Reply-To: <1463043285-14702-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1463043285-14702-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1463043285-14702-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can choose which one to
use.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 119 ++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f334a3a..ad1df83 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -302,8 +302,9 @@
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
+		       <&dmac1 0x21>, <&dmac1 0x22>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -315,8 +316,9 @@
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
+		       <&dmac1 0x25>, <&dmac1 0x26>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -328,8 +330,9 @@
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
+		       <&dmac1 0x27>, <&dmac1 0x28>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -341,8 +344,9 @@
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
+		       <&dmac1 0x1b>, <&dmac1 0x1c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -354,8 +358,9 @@
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
+		       <&dmac1 0x1f>, <&dmac1 0x20>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -367,8 +372,9 @@
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
+		       <&dmac1 0x23>, <&dmac1 0x24>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -380,8 +386,9 @@
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -393,8 +400,9 @@
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+		       <&dmac1 0x19>, <&dmac1 0x1a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -406,8 +414,9 @@
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+		       <&dmac1 0x1d>, <&dmac1 0x1e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -420,8 +429,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+		       <&dmac1 0x29>, <&dmac1 0x2a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -434,8 +444,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+		       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -448,8 +459,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+		       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -462,8 +474,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+		       <&dmac1 0x2f>, <&dmac1 0x30>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -476,8 +489,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+		       <&dmac1 0xfb>, <&dmac1 0xfc>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -490,8 +504,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+		       <&dmac1 0xfd>, <&dmac1 0xfe>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -504,8 +519,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+		       <&dmac1 0x39>, <&dmac1 0x3a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -518,8 +534,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+		       <&dmac1 0x4d>, <&dmac1 0x4e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -532,8 +549,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
+		       <&dmac1 0x3b>, <&dmac1 0x3c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -640,8 +658,9 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
-		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+		       <&dmac1 0x61>, <&dmac1 0x62>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -653,8 +672,9 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
-		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+		       <&dmac1 0x65>, <&dmac1 0x66>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -666,8 +686,9 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
-		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
@@ -678,6 +699,9 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+		       <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -687,6 +711,9 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+		       <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -696,6 +723,9 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+		       <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -705,8 +735,9 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
-		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+		       <&dmac1 0x17>, <&dmac1 0x18>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
-- 
2.8.2
