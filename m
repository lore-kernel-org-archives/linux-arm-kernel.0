From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 12 Jul 2017 12:34:21 +0200
Subject: [PATCH v3] arm64: dts: r8a7795: Add all MSIOF nodes
Message-ID: <1499855661-21386-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device nodes for all MSIOF SPI controllers, incl. clocks, power
domain, dma, and reset properties.

Due to a hardware erratum on R-Car H3 ES1.x, using MSIOF for SPI is only
supported on ES2.0 and later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on r8a7795/salvator-xs with MSIOF3(A) connected to a HD44780
character LCD through a pair of 74HCT595 shift registers.

v3:
  - Add resets properties,
  - Add family-specific compatible values,
  - Add link to second DMA controller for MSIOF[01],

v2:
  - Rebased,
  - Switch to final CPG/MSSR bindings,
  - Change one-line summary prefix to match current arm-soc practices.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 6f5130766a212d6d..507d8ad07aaf9007 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -899,6 +899,68 @@
 			status = "disabled";
 		};
 
+		msiof0: spi at e6e90000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 211>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof1: spi at e6ea0000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 210>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof2: spi at e6c00000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 209>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof3: spi at e6c10000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 208>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a7795",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
2.7.4
