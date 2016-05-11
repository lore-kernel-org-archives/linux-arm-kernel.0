From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Wed, 11 May 2016 15:13:55 +0200
Subject: [PATCHv3 1/4] ARM: dts: r8a7790: Reference both DMA controllers
In-Reply-To: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1462972438-20797-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can choose which one to
use.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7790.dtsi | 131 ++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 83cf23c..14fcd19 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -517,8 +517,9 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
-		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+		       <&dmac1 0x61>, <&dmac1 0x62>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -530,8 +531,9 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
-		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+		       <&dmac1 0x65>, <&dmac1 0x66>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -543,8 +545,9 @@
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
-		dmas = <&dmac0 0x69>, <&dmac0 0x6a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x69>, <&dmac0 0x6a>,
+		       <&dmac1 0x69>, <&dmac1 0x6a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -556,8 +559,9 @@
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
-		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
+		       <&dmac1 0x77>, <&dmac1 0x78>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -567,8 +571,9 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
-		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
@@ -580,8 +585,9 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
-		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
+		       <&dmac1 0xe1>, <&dmac1 0xe2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
@@ -598,8 +604,9 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
-		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+		       <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -610,8 +617,9 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
-		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
+		       <&dmac1 0xc9>, <&dmac1 0xca>;
+		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -622,8 +630,9 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
-		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+		       <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -634,8 +643,9 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
-		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+		       <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -648,8 +658,9 @@
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
+		       <&dmac1 0x21>, <&dmac1 0x22>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -661,8 +672,9 @@
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
+		       <&dmac1 0x25>, <&dmac1 0x26>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -674,8 +686,9 @@
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
+		       <&dmac1 0x27>, <&dmac1 0x28>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -687,8 +700,9 @@
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -700,8 +714,9 @@
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+		       <&dmac1 0x19>, <&dmac1 0x1a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -713,8 +728,9 @@
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+		       <&dmac1 0x1d>, <&dmac1 0x1e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -727,8 +743,9 @@
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+		       <&dmac1 0x29>, <&dmac1 0x2a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -741,8 +758,9 @@
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+		       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -755,9 +773,9 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SCIF2>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
-		dma-names = "tx", "rx";
-		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+		       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		status = "disabled";
 	};
 
@@ -769,8 +787,9 @@
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+		       <&dmac1 0x39>, <&dmac1 0x3a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -783,8 +802,9 @@
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+		       <&dmac1 0x4d>, <&dmac1 0x4e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -1469,8 +1489,9 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
-		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+		       <&dmac1 0x17>, <&dmac1 0x18>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
@@ -1483,8 +1504,9 @@
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
-		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x51>, <&dmac0 0x52>,
+		       <&dmac1 0x51>, <&dmac1 0x52>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1496,8 +1518,9 @@
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
-		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x55>, <&dmac0 0x56>,
+		       <&dmac1 0x55>, <&dmac1 0x56>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1509,8 +1532,9 @@
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
-		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x41>, <&dmac0 0x42>,
+		       <&dmac1 0x41>, <&dmac1 0x42>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1522,8 +1546,9 @@
 		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
-		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x45>, <&dmac0 0x46>,
+		       <&dmac1 0x45>, <&dmac1 0x46>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.8.2
