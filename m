From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 12 Mar 2018 15:24:14 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a7795: Add missing SYS-DMAC2 dmas
Message-ID: <1520864654-10664-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On R-Car H3, on-chip peripheral modules that can make use of DMA are
wired to either SYS-DMAC0 only, or to both SYS-DMAC1 and SYS-DMAC2.

Add the missing DMA properties pointing to SYS-DMAC2 for HSCIF[0-2],
SCIF[0125], and I2C[0-2].  These were initially left out because early
firmware versions prohibited using SYS-DMAC2.  This restriction has been
lifted in IPL and Secure Monitor Rev1.0.6 (released on Feb 25, 2016).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
FTR, other devices already have dmas pointing to SYS-DMAC2.

v2:
  - Add Reviewed-by,
  - Update forgotten SCIF2 node.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 50 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0648fe451d097f4e..1d5e3ac0231ca6ab 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1076,8 +1076,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
+			       <&dmac2 0x31>, <&dmac2 0x30>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 520>;
 			status = "disabled";
@@ -1093,8 +1094,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
+			       <&dmac2 0x33>, <&dmac2 0x32>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 519>;
 			status = "disabled";
@@ -1110,8 +1112,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
+			       <&dmac2 0x35>, <&dmac2 0x34>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 518>;
 			status = "disabled";
@@ -1222,8 +1225,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
+			       <&dmac2 0x51>, <&dmac2 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 207>;
 			status = "disabled";
@@ -1238,8 +1242,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
+			       <&dmac2 0x53>, <&dmac2 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 206>;
 			status = "disabled";
@@ -1254,8 +1259,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
@@ -1302,8 +1308,9 @@
 				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
+			       <&dmac2 0x5b>, <&dmac2 0x5a>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 202>;
 			status = "disabled";
@@ -1335,8 +1342,9 @@
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 931>;
-			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
+			       <&dmac2 0x91>, <&dmac2 0x90>;
+			dma-names = "tx", "rx", "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -1351,8 +1359,9 @@
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 930>;
-			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
+			       <&dmac2 0x93>, <&dmac2 0x92>;
+			dma-names = "tx", "rx", "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -1367,8 +1376,9 @@
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 929>;
-			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
-			dma-names = "tx", "rx";
+			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
+			       <&dmac2 0x95>, <&dmac2 0x94>;
+			dma-names = "tx", "rx", "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
-- 
2.7.4
