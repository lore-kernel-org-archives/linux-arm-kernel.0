From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:45 +0200
Subject: [PATCH 05/23] ARM: dts: r8a7790: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 9 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 9 has a unit name, but no reg property

Move the cache-controller nodes under the cpus node, and make their unit
names and reg properties match the MPIDR values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 94 +++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3b9e98be2f7b3122..66ab056c7f212929 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -127,6 +127,22 @@
 			power-domains = <&sysc R8A7790_PD_CA7_CPU3>;
 			next-level-cache = <&L2_CA7>;
 		};
+
+		L2_CA15: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			power-domains = <&sysc R8A7790_PD_CA15_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		L2_CA7: cache-controller at 100 {
+			compatible = "cache";
+			reg = <100>;
+			power-domains = <&sysc R8A7790_PD_CA7_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	thermal-zones {
@@ -148,20 +164,6 @@
 		};
 	};
 
-	L2_CA15: cache-controller at 0 {
-		compatible = "cache";
-		power-domains = <&sysc R8A7790_PD_CA15_SCU>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
-	L2_CA7: cache-controller at 1 {
-		compatible = "cache";
-		power-domains = <&sysc R8A7790_PD_CA7_SCU>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
@@ -1702,79 +1704,79 @@
 		status = "disabled";
 
 		rcar_sound,dvc {
-			dvc0: dvc at 0 {
+			dvc0: dvc-0 {
 				dmas = <&audma0 0xbc>;
 				dma-names = "tx";
 			};
-			dvc1: dvc at 1 {
+			dvc1: dvc-1 {
 				dmas = <&audma0 0xbe>;
 				dma-names = "tx";
 			};
 		};
 
 		rcar_sound,mix {
-			mix0: mix at 0 { };
-			mix1: mix at 1 { };
+			mix0: mix-0 { };
+			mix1: mix-1 { };
 		};
 
 		rcar_sound,ctu {
-			ctu00: ctu at 0 { };
-			ctu01: ctu at 1 { };
-			ctu02: ctu at 2 { };
-			ctu03: ctu at 3 { };
-			ctu10: ctu at 4 { };
-			ctu11: ctu at 5 { };
-			ctu12: ctu at 6 { };
-			ctu13: ctu at 7 { };
+			ctu00: ctu-0 { };
+			ctu01: ctu-1 { };
+			ctu02: ctu-2 { };
+			ctu03: ctu-3 { };
+			ctu10: ctu-4 { };
+			ctu11: ctu-5 { };
+			ctu12: ctu-6 { };
+			ctu13: ctu-7 { };
 		};
 
 		rcar_sound,src {
-			src0: src at 0 {
+			src0: src-0 {
 				interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x85>, <&audma1 0x9a>;
 				dma-names = "rx", "tx";
 			};
-			src1: src at 1 {
+			src1: src-1 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x87>, <&audma1 0x9c>;
 				dma-names = "rx", "tx";
 			};
-			src2: src at 2 {
+			src2: src-2 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x89>, <&audma1 0x9e>;
 				dma-names = "rx", "tx";
 			};
-			src3: src at 3 {
+			src3: src-3 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8b>, <&audma1 0xa0>;
 				dma-names = "rx", "tx";
 			};
-			src4: src at 4 {
+			src4: src-4 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8d>, <&audma1 0xb0>;
 				dma-names = "rx", "tx";
 			};
-			src5: src at 5 {
+			src5: src-5 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8f>, <&audma1 0xb2>;
 				dma-names = "rx", "tx";
 			};
-			src6: src at 6 {
+			src6: src-6 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x91>, <&audma1 0xb4>;
 				dma-names = "rx", "tx";
 			};
-			src7: src at 7 {
+			src7: src-7 {
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x93>, <&audma1 0xb6>;
 				dma-names = "rx", "tx";
 			};
-			src8: src at 8 {
+			src8: src-8 {
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x95>, <&audma1 0xb8>;
 				dma-names = "rx", "tx";
 			};
-			src9: src at 9 {
+			src9: src-9 {
 				interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x97>, <&audma1 0xba>;
 				dma-names = "rx", "tx";
@@ -1782,52 +1784,52 @@
 		};
 
 		rcar_sound,ssi {
-			ssi0: ssi at 0 {
+			ssi0: ssi-0 {
 				interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi1: ssi at 1 {
+			ssi1: ssi-1 {
 				 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi2: ssi at 2 {
+			ssi2: ssi-2 {
 				interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi3: ssi at 3 {
+			ssi3: ssi-3 {
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi4: ssi at 4 {
+			ssi4: ssi-4 {
 				interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi5: ssi at 5 {
+			ssi5: ssi-5 {
 				interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi6: ssi at 6 {
+			ssi6: ssi-6 {
 				interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi7: ssi at 7 {
+			ssi7: ssi-7 {
 				interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi8: ssi at 8 {
+			ssi8: ssi-8 {
 				interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-			ssi9: ssi at 9 {
+			ssi9: ssi-9 {
 				interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
 				dma-names = "rx", "tx", "rxu", "txu";
-- 
1.9.1
