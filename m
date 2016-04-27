From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:20:33 +1000
Subject: [PATCH 06/10] ARM: dts: r8a7779: Use SYSC "always-on" PM Domain
In-Reply-To: <cover.1461730638.git.horms+renesas@verge.net.au>
References: <cover.1461730638.git.horms+renesas@verge.net.au>
Message-ID: <751e29bbb64ad091c6f51704f31224aaec560f69.1461730638.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Hook up all devices that are part of the CPG/MSTP Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index e02875a8c040..d43e3b2105ae 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -177,7 +177,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -188,7 +188,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -199,7 +199,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -210,7 +210,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -222,7 +222,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -234,7 +234,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -246,7 +246,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -258,7 +258,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -270,7 +270,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -282,7 +282,7 @@
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>,
 			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -304,7 +304,7 @@
 			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 
 		#renesas,channels = <3>;
 
@@ -319,7 +319,7 @@
 			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 
 		#renesas,channels = <3>;
 
@@ -334,7 +334,7 @@
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 
 		#renesas,channels = <3>;
 
@@ -346,7 +346,7 @@
 		reg = <0xfc600000 0x2000>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 	};
 
 	sdhi0: sd at ffe4c000 {
@@ -354,7 +354,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -363,7 +363,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -372,7 +372,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -381,7 +381,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -392,7 +392,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -403,7 +403,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -414,7 +414,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -423,7 +423,7 @@
 		reg = <0 0xfff80000 0 0x40000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_DU>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		ports {
-- 
2.7.0.rc3.207.g0ac5344
