From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:34 +0900
Subject: [PATCH 03/30] ARM: shmobile: r8a7779 dtsi: Change to using
 clock-indices
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <64530fc2ce234e2ba227e24a149c73ef91dbfae5.1419812185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ede9a29..e3846af 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -475,7 +475,7 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_HSPI R8A7779_CLK_TMU2
 				R8A7779_CLK_TMU1 R8A7779_CLK_TMU0
 				R8A7779_CLK_HSCIF1 R8A7779_CLK_HSCIF0
@@ -506,7 +506,7 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_USB01 R8A7779_CLK_USB2
 				R8A7779_CLK_DU R8A7779_CLK_VIN2
 				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
@@ -527,7 +527,7 @@
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
 				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
 				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0
-- 
2.1.3
