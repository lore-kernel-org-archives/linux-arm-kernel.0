From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:32 +0900
Subject: [PATCH 19/24] ARM: shmobile: r8a7779 dtsi: Update unit-addresses for
 clocks
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <2909b8746d6f5534aa7714d2df110b3633a59556.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

  - Correct the unit-address for the "cpg_clocks" node,
  - Add missing unit-addresses for the "mstp*_clks" nodes,
  - Rename "cpg_clocks" and "mstp*_clks" nodes to the more generic
    "clocks".

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 038c16a..27bf227 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -298,7 +298,7 @@
 		};
 
 		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at 0xe6150000 {
+		cpg_clocks: clocks at ffc80000 {
 			compatible = "renesas,r8a7779-cpg-clocks";
 			reg = <0 0xffc80000 0 0x30>;
 			clocks = <&extal_clk>;
@@ -342,7 +342,7 @@
 		};
 
 		/* Gate clocks */
-		mstp0_clks: mstp0_clks {
+		mstp0_clks: clocks at ffc80030 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
 			reg = <0 0xffc80030 0 4>;
@@ -379,7 +379,7 @@
 				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
 				"i2c0";
 		};
-		mstp1_clks: mstp1_clks {
+		mstp1_clks: clocks at ffc80034 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
 			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
@@ -408,7 +408,7 @@
 				"ether", "sata",
 				"pcie", "vin3";
 		};
-		mstp3_clks: mstp3_clks {
+		mstp3_clks: clocks at ffc8003c {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
 			reg = <0 0xffc8003c 0 4>;
-- 
2.0.0.rc2
