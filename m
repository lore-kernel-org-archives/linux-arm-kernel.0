From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Sep 2017 22:43:21 +0300
Subject: [PATCH v2 3/8] arm64: dts: renesas: r8a77970: add SYS-DMAC support
Message-ID: <20170915194429.260616486@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe SYS-DMAC1/2 in the R8A77970 device tree.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- replaced  the use of the SYSC power domain #define's with the bare numbers;
- refreshed the patch;
- added Geert's tag.

 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -121,5 +121,53 @@
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
 		};
+
+		dmac1: dma-controller at e7300000 {
+			compatible = "renesas,dmac-r8a77970",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7300000 0 0x10000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <8>;
+		};
+
+		dmac2: dma-controller at e7310000 {
+			compatible = "renesas,dmac-r8a77970",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7310000 0 0x10000>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7";
+			clocks = <&cpg CPG_MOD 217>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 217>;
+			#dma-cells = <1>;
+			dma-channels = <8>;
+		};
 	};
 };
