From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 21 Nov 2016 18:26:53 +0100
Subject: [PATCH] arm64: dts: r8a7796: Add all MSIOF nodes
Message-ID: <1479749213-13744-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device nodes for all MSIOF SPI controllers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested with MSIOF2(B) on EXIO connector D of r8a7796/salvator-x, using
spidev, gpio-74x164, and a logic analyzer.

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 41a050d2f1925552..c34c684088542850 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -368,6 +368,60 @@
 			status = "disabled";
 		};
 
+		msiof0: spi at e6e90000 {
+			compatible = "renesas,msiof-r8a7796";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof1: spi at e6ea0000 {
+			compatible = "renesas,msiof-r8a7796";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof2: spi at e6c00000 {
+			compatible = "renesas,msiof-r8a7796";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof3: spi at e6c10000 {
+			compatible = "renesas,msiof-r8a7796";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7796",
 				     "renesas,rcar-dmac";
-- 
1.9.1
