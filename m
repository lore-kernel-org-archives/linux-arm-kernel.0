From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:04 +0900
Subject: [PATCH 4/7] ARM: shmobile: r8a7779 dtsi: Remove superfluous
 interrupt-parent
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
Message-ID: <6a7147f53f29887e627d84c0a562c8bb87691e9d.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

There's already an "interrupt-parent = <&gic>;" at the top, which is
inherited by all child nodes, so the "interrupt-parent" properties in
the serial nodes can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 58d0d95..0e64c76 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -199,7 +199,6 @@
 	scif0: serial at ffe40000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -209,7 +208,6 @@
 	scif1: serial at ffe41000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -219,7 +217,6 @@
 	scif2: serial at ffe42000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -229,7 +226,6 @@
 	scif3: serial at ffe43000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -239,7 +235,6 @@
 	scif4: serial at ffe44000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -249,7 +244,6 @@
 	scif5: serial at ffe45000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
-- 
2.0.1
