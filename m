From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:06 +0100
Subject: [PATCH 07/29] ARM: dts: r8a7791: Correct SCIFB reg properties to
 cover all registers
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <5f25f9f52e1954d3ccec43976e10ea1a8075e536.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Several SCIFB registers reside outside the reported register ranges.
Fortunately this works (on Linux), due to the PAGE_SIZE granularity of
ioremap().

Extend the sizes from 64 to 0x100 bytes to fix this, like is done on
SH/R-Mobile SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b07c799f72f2..091d7fb6ee7d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -702,7 +702,7 @@
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a7791",
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6c20000 0 64>;
+		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
 		clock-names = "fck";
@@ -716,7 +716,7 @@
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7791",
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6c30000 0 64>;
+		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
 		clock-names = "fck";
@@ -730,7 +730,7 @@
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a7791",
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6ce0000 0 64>;
+		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
 		clock-names = "fck";
-- 
2.7.0.rc3.207.g0ac5344
