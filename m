From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Nov 2018 14:03:12 +0100
Subject: [PATCH 10/16] ARM: dts: r8a77470: Add USB-DMAC device nodes
In-Reply-To: <cover.1543409901.git.horms+renesas@verge.net.au>
References: <cover.1543409901.git.horms+renesas@verge.net.au>
Message-ID: <92c3ccd9b847a6cf130e10aa305e9e349626e4f0.1543409901.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds USB DMAC nodes.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index a703b74cc1f9..0a7ca2ff4dc4 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -325,6 +325,62 @@
 			status = "disabled";
 		};
 
+		usb_dmac00: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac10: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac01: dma-controller at e65a8000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a8000 0 0x100>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 326>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 326>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac11: dma-controller at e65b8000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b8000 0 0x100>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 327>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 327>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77470",
 				     "renesas,rcar-dmac";
-- 
2.11.0
