From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:47 +0900
Subject: [PATCH 17/25] ARM: shmobile: r8a7793: Describe DMA for the serial
 ports
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <4b0f88796bd3d19331550dad2a9d958091f874a2.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.

Based on similar work for the r8a7791 by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 309b33d60001..df607a92b2ed 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -303,6 +303,8 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -313,6 +315,8 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -323,6 +327,8 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -333,6 +339,8 @@
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -343,6 +351,8 @@
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -353,6 +363,8 @@
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -363,6 +375,8 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -373,6 +387,8 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -383,6 +399,8 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -393,6 +411,8 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -403,6 +423,8 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -413,6 +435,8 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -423,6 +447,8 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -433,6 +459,8 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -443,6 +471,8 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -453,6 +483,8 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -463,6 +495,8 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -473,6 +507,8 @@
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.1.4
