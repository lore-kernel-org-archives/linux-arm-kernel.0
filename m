From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:22 +0100
Subject: [PATCH 28/70] ARM: dts: r8a7793: add audio DMAC to device tree
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <6708eb73183e226ddd73dae128239e76b3807390.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the two Audio DMA controllers in the r8a7791 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cb6251e71ef9..2c9ab9f18b41 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -301,6 +301,64 @@
 		dma-channels = <15>;
 	};
 
+	audma0: dma-controller at ec700000 {
+		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
+		reg = <0 0xec700000 0 0x10000>;
+		interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC0>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
+	audma1: dma-controller at ec720000 {
+		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
+		reg = <0 0xec720000 0 0x10000>;
+		interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC1>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
-- 
2.7.0.rc3.207.g0ac5344
