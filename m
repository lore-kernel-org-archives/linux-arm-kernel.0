From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:44 +0900
Subject: [PATCH 7/9] arm64: dts: r8a7795: Fix W=1 dtc warnings
In-Reply-To: <cover.1465347183.git.horms+renesas@verge.net.au>
References: <cover.1465347183.git.horms+renesas@verge.net.au>
Message-ID: <6f7bf82cc912441f5824f0b1a6497164e5ebe079.1465347183.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,dvc/dvc at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,src/src at 9 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/sound at ec500000/rcar_sound,ssi/ssi at 9 has a unit name, but no reg property

Move the cache-controller nodes under the cpus node, and make their unit
names and reg properties match the MPIDR values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 70 ++++++++++++++++----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bf38df355006..a4f4ec8daa21 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -69,20 +69,22 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
-	};
 
-	L2_CA57: cache-controller at 0 {
-		compatible = "cache";
-		power-domains = <&sysc R8A7795_PD_CA57_SCU>;
-		cache-unified;
-		cache-level = <2>;
-	};
+		L2_CA57: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			power-domains = <&sysc R8A7795_PD_CA57_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 
-	L2_CA53: cache-controller at 1 {
-		compatible = "cache";
-		power-domains = <&sysc R8A7795_PD_CA53_SCU>;
-		cache-unified;
-		cache-level = <2>;
+		L2_CA53: cache-controller at 100 {
+			compatible = "cache";
+			reg = <0x100>;
+			power-domains = <&sysc R8A7795_PD_CA53_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	extal_clk: extal {
@@ -896,63 +898,63 @@
 			status = "disabled";
 
 			rcar_sound,dvc {
-				dvc0: dvc at 0 {
+				dvc0: dvc-0 {
 					dmas = <&audma0 0xbc>;
 					dma-names = "tx";
 				};
-				dvc1: dvc at 1 {
+				dvc1: dvc-1 {
 					dmas = <&audma0 0xbe>;
 					dma-names = "tx";
 				};
 			};
 
 			rcar_sound,src {
-				src0: src at 0 {
+				src0: src-0 {
 					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x85>, <&audma1 0x9a>;
 					dma-names = "rx", "tx";
 				};
-				src1: src at 1 {
+				src1: src-1 {
 					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x87>, <&audma1 0x9c>;
 					dma-names = "rx", "tx";
 				};
-				src2: src at 2 {
+				src2: src-2 {
 					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x89>, <&audma1 0x9e>;
 					dma-names = "rx", "tx";
 				};
-				src3: src at 3 {
+				src3: src-3 {
 					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
 					dma-names = "rx", "tx";
 				};
-				src4: src at 4 {
+				src4: src-4 {
 					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
 					dma-names = "rx", "tx";
 				};
-				src5: src at 5 {
+				src5: src-5 {
 					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
 					dma-names = "rx", "tx";
 				};
-				src6: src at 6 {
+				src6: src-6 {
 					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x91>, <&audma1 0xb4>;
 					dma-names = "rx", "tx";
 				};
-				src7: src at 7 {
+				src7: src-7 {
 					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x93>, <&audma1 0xb6>;
 					dma-names = "rx", "tx";
 				};
-				src8: src at 8 {
+				src8: src-8 {
 					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x95>, <&audma1 0xb8>;
 					dma-names = "rx", "tx";
 				};
-				src9: src at 9 {
+				src9: src-9 {
 					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x97>, <&audma1 0xba>;
 					dma-names = "rx", "tx";
@@ -960,52 +962,52 @@
 			};
 
 			rcar_sound,ssi {
-				ssi0: ssi at 0 {
+				ssi0: ssi-0 {
 					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi1: ssi at 1 {
+				ssi1: ssi-1 {
 					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi2: ssi at 2 {
+				ssi2: ssi-2 {
 					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi3: ssi at 3 {
+				ssi3: ssi-3 {
 					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi4: ssi at 4 {
+				ssi4: ssi-4 {
 					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi5: ssi at 5 {
+				ssi5: ssi-5 {
 					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi6: ssi at 6 {
+				ssi6: ssi-6 {
 					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi7: ssi at 7 {
+				ssi7: ssi-7 {
 					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi8: ssi at 8 {
+				ssi8: ssi-8 {
 					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-				ssi9: ssi at 9 {
+				ssi9: ssi-9 {
 					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
 					dma-names = "rx", "tx", "rxu", "txu";
-- 
2.1.4
