From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:52:46 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7793: Describe DMA for the serial ports
In-Reply-To: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
References: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448589166-11612-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.

Based on similar work for the r8a7791 by Geert Uytterhoeven.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 3ac2ec0414a0..8d5cbdfc3d5d 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -304,6 +304,8 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -314,6 +316,8 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -324,6 +328,8 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -334,6 +340,8 @@
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -344,6 +352,8 @@
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -354,6 +364,8 @@
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -364,6 +376,8 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -374,6 +388,8 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -384,6 +400,8 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -394,6 +412,8 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -404,6 +424,8 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -414,6 +436,8 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -424,6 +448,8 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -434,6 +460,8 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -444,6 +472,8 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -454,6 +484,8 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -464,6 +496,8 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
+		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -474,6 +508,8 @@
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
