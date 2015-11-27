From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:25 +0900
Subject: [PATCH 08/18] arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
In-Reply-To: <cover.1448587800.git.horms+renesas@verge.net.au>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
Message-ID: <4fa04299184604d5ae85a3ebe795e19eb564fc67.1448587800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device nodes for all HSCIF serial ports, incl. clocks, clock
domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c01a7e4f59a4..348baebffeac 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -262,6 +262,66 @@
 			#size-cells = <0>;
 		};
 
+		hscif0: serial at e6540000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6540000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 520>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif1: serial at e6550000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6550000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 519>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif2: serial at e6560000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6560000 0 96>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 518>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif3: serial at e66a0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66a0000 0 96>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 517>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hscif4: serial at e66b0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66b0000 0 96>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 516>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
-- 
2.1.4
