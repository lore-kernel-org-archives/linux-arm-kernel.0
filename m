From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 06:36:02 +0000
Subject: [PATCH 01/12] arm64: renesas: r8a7795: add AUDIO_DMAC support
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <871tbe8ubn.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c01a7e4..18d2221 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -203,6 +203,70 @@
 			#power-domain-cells = <0>;
 		};
 
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts =	<0 350 IRQ_TYPE_LEVEL_HIGH
+					 0 320 IRQ_TYPE_LEVEL_HIGH
+					 0 321 IRQ_TYPE_LEVEL_HIGH
+					 0 322 IRQ_TYPE_LEVEL_HIGH
+					 0 323 IRQ_TYPE_LEVEL_HIGH
+					 0 324 IRQ_TYPE_LEVEL_HIGH
+					 0 325 IRQ_TYPE_LEVEL_HIGH
+					 0 326 IRQ_TYPE_LEVEL_HIGH
+					 0 327 IRQ_TYPE_LEVEL_HIGH
+					 0 328 IRQ_TYPE_LEVEL_HIGH
+					 0 329 IRQ_TYPE_LEVEL_HIGH
+					 0 330 IRQ_TYPE_LEVEL_HIGH
+					 0 331 IRQ_TYPE_LEVEL_HIGH
+					 0 332 IRQ_TYPE_LEVEL_HIGH
+					 0 333 IRQ_TYPE_LEVEL_HIGH
+					 0 334 IRQ_TYPE_LEVEL_HIGH
+					 0 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts =	<0 351 IRQ_TYPE_LEVEL_HIGH
+					 0 336 IRQ_TYPE_LEVEL_HIGH
+					 0 337 IRQ_TYPE_LEVEL_HIGH
+					 0 338 IRQ_TYPE_LEVEL_HIGH
+					 0 339 IRQ_TYPE_LEVEL_HIGH
+					 0 340 IRQ_TYPE_LEVEL_HIGH
+					 0 341 IRQ_TYPE_LEVEL_HIGH
+					 0 342 IRQ_TYPE_LEVEL_HIGH
+					 0 343 IRQ_TYPE_LEVEL_HIGH
+					 0 344 IRQ_TYPE_LEVEL_HIGH
+					 0 345 IRQ_TYPE_LEVEL_HIGH
+					 0 346 IRQ_TYPE_LEVEL_HIGH
+					 0 347 IRQ_TYPE_LEVEL_HIGH
+					 0 348 IRQ_TYPE_LEVEL_HIGH
+					 0 349 IRQ_TYPE_LEVEL_HIGH
+					 0 382 IRQ_TYPE_LEVEL_HIGH
+					 0 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 501>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		pfc: pfc at e6060000 {
 			compatible = "renesas,pfc-r8a7795";
 			reg = <0 0xe6060000 0 0x50c>;
-- 
1.9.1
