From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:46 +0200
Subject: [PATCH 13/69] ARM: dts: r8a77470: Add SYS-DMAC support
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <2e5775e3fd0667f7140a00748465af1c3d0aa5bb.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Describe SYS-DMAC0/1 in the R8A77470 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 45785828771b..c39acebc6a72 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -104,6 +104,72 @@
 			reg = <0 0xe6300000 0 0x20000>;
 		};
 
+		dmac0: dma-controller at e6700000 {
+			compatible = "renesas,dmac-r8a77470",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x20000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 219>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 219>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
+
+		dmac1: dma-controller at e6720000 {
+			compatible = "renesas,dmac-r8a77470",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6720000 0 0x20000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
+
 		scif1: serial at e6e68000 {
 			compatible = "renesas,scif-r8a77470",
 				     "renesas,rcar-gen2-scif", "renesas,scif";
-- 
2.11.0
