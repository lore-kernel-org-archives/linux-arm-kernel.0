From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Oct 2015 15:01:48 +0900
Subject: [PATCH v12 3/7] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
In-Reply-To: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1445839312-8874-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device nodes for all R-Car H3 SCIF serial ports, incl. clocks,
clock domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since V11 (Simon Horman <horms+renesas@verge.net.au>)
- Update for new CPG/MSSR bindings via Geert Uytterhoeven

Changes since V10 (Simon Horman <horms+renesas@verge.net.au>)
- As suggested by Geert Uyterhoven
  + R8A7795_CLK_SCIF2  is 310 not 210

Changes since V10 (Simon Horman <horms+renesas@verge.net.au>)
- As suggested by Geert Uyterhoven
  + R8A7795_CLK_SCIF2  is 310 not 210

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
- Added SCIF2 DMA bits again
- Converted DT nodes for MSTP to MSSR, adjusted r8a7795-clock.h
- Include clock-output-names

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- Dropped SCIF2 DMA bits - thanks Laurent!
- Changed name of mstp2 and mstp3 nodes - thanks Geert!
- Added Acked-by from Laurent

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Folded together above SCIF2 patches
- Added SCIF2 DMA bits
- Got rid of clock-output-names
- Replaced renesas,clock-indices with clock-indices

Based on:
 [PATCH 9/25] arm64: renesas: r8a7795: Add SCIF2 support
 [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
 [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 020207e1afe6..3e5539cceeec 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/clock/r8a7795-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -90,5 +91,77 @@
 		dmac2: dma-controller at e7310000 {
 			/* Empty node for now */
 		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6c50000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6c40000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6f30000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
