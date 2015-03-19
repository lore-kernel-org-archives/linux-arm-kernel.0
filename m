From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 11:15:24 +0900
Subject: [PATCH 6/6] ARM: shmobile: r8a7791: sound enables Audio DMAC entry on
 DTSI
In-Reply-To: <cover.1426731062.git.horms+renesas@verge.net.au>
References: <cover.1426731062.git.horms+renesas@verge.net.au>
Message-ID: <63573339e7698503bfeaef3bb0c444ffc98e45a0.1426731062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds Audio DMAC (= rcar-dmac) entry for sound

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 130 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a697b94..4696062 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1524,34 +1524,120 @@
 		status = "disabled";
 
 		rcar_sound,dvc {
-			dvc0: dvc at 0 { };
-			dvc1: dvc at 1 { };
+			dvc0: dvc at 0 {
+				dmas = <&audma0 0xbc>;
+				dma-names = "tx";
+			};
+			dvc1: dvc at 1 {
+				dmas = <&audma0 0xbe>;
+				dma-names = "tx";
+			};
 		};
 
 		rcar_sound,src {
-			src0: src at 0 { interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>; };
-			src1: src at 1 { interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>; };
-			src2: src at 2 { interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>; };
-			src3: src at 3 { interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>; };
-			src4: src at 4 { interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>; };
-			src5: src at 5 { interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>; };
-			src6: src at 6 { interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>; };
-			src7: src at 7 { interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>; };
-			src8: src at 8 { interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>; };
-			src9: src at 9 { interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>; };
+			src0: src at 0 {
+				interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x85>, <&audma1 0x9a>;
+				dma-names = "rx", "tx";
+			};
+			src1: src at 1 {
+				interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x87>, <&audma1 0x9c>;
+				dma-names = "rx", "tx";
+			};
+			src2: src at 2 {
+				interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x89>, <&audma1 0x9e>;
+				dma-names = "rx", "tx";
+			};
+			src3: src at 3 {
+				interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x8b>, <&audma1 0xa0>;
+				dma-names = "rx", "tx";
+			};
+			src4: src at 4 {
+				interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x8d>, <&audma1 0xb0>;
+				dma-names = "rx", "tx";
+			};
+			src5: src at 5 {
+				interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x8f>, <&audma1 0xb2>;
+				dma-names = "rx", "tx";
+			};
+			src6: src at 6 {
+				interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x91>, <&audma1 0xb4>;
+				dma-names = "rx", "tx";
+			};
+			src7: src at 7 {
+				interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x93>, <&audma1 0xb6>;
+				dma-names = "rx", "tx";
+			};
+			src8: src at 8 {
+				interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x95>, <&audma1 0xb8>;
+				dma-names = "rx", "tx";
+			};
+			src9: src at 9 {
+				interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x97>, <&audma1 0xba>;
+				dma-names = "rx", "tx";
+			};
 		};
 
 		rcar_sound,ssi {
-			ssi0: ssi at 0 { interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi1: ssi at 1 { interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi2: ssi at 2 { interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi3: ssi at 3 { interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi4: ssi at 4 { interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi5: ssi at 5 { interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi6: ssi at 6 { interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi7: ssi at 7 { interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi8: ssi at 8 { interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi9: ssi at 9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi0: ssi at 0 {
+				interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi1: ssi at 1 {
+				 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi2: ssi at 2 {
+				interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi3: ssi at 3 {
+				interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi4: ssi at 4 {
+				interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi5: ssi at 5 {
+				interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi6: ssi at 6 {
+				interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi7: ssi at 7 {
+				interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi8: ssi at 8 {
+				interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
+			ssi9: ssi at 9 {
+				interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+				dma-names = "rx", "tx", "rxu", "txu";
+			};
 		};
 	};
 };
-- 
2.1.4
