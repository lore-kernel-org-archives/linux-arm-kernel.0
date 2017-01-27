From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 10:14:29 +0100
Subject: [PATCH 7/9] arm64: dts: r8a7795: tidyup audma definition order
In-Reply-To: <cover.1485508214.git.horms+renesas@verge.net.au>
References: <cover.1485508214.git.horms+renesas@verge.net.au>
Message-ID: <769fa8369b9db469ffacb356766b78dd1c7eae5a.1485508214.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current r8a7795.dtsi defines audma -> ipmmu -> dma order.
Because of this order, dma can connect to ipmmu, but
audma can't connect to it.
This patch moves audma order as ipmmu -> dma -> audma.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 132 +++++++++++++++----------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8b030c323c10..74a4e1ad057d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -340,72 +340,6 @@
 			#power-domain-cells = <1>;
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7795",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec700000 0 0x10000>;
-			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&cpg CPG_MOD 502>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-		};
-
-		audma1: dma-controller at ec720000 {
-			compatible = "renesas,dmac-r8a7795",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec720000 0 0x10000>;
-			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&cpg CPG_MOD 501>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-		};
-
 		pfc: pfc at e6060000 {
 			compatible = "renesas,pfc-r8a7795";
 			reg = <0 0xe6060000 0 0x50c>;
@@ -525,6 +459,72 @@
 			dma-channels = <16>;
 		};
 
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 501>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		avb: ethernet at e6800000 {
 			compatible = "renesas,etheravb-r8a7795",
 				     "renesas,etheravb-rcar-gen3";
-- 
2.7.0.rc3.207.g0ac5344
