From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:40 +0200
Subject: [PATCH 21/26] ARM: dts: r8a7794: add Audio-DMAC support
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <298e4ee3d213a0764e8d4baa5336d4d1649a5bc5.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe Audio-DMAC in the R8A7794 device tree.

This patch is loosely based on the commit 8994fff67761 ("ARM: shmobile:
r8a7791: Add Audio DMAC devices to DT").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index cba41c199fd8..668e1383dd09 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -296,6 +296,34 @@
 		dma-channels = <15>;
 	};
 
+	audma0: dma-controller at ec700000 {
+		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
+		reg = <0 0xec700000 0 0x10000>;
+		interrupts =	<GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				  "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
+				  "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
+				  "ch12";
+		clocks = <&mstp5_clks R8A7794_CLK_AUDIO_DMAC0>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7794",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.0.rc3.207.g0ac5344
