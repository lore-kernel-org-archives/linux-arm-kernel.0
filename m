From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:46 +0200
Subject: [PATCH 51/58] arm64: dts: renesas: r8a7795: Move arm_cc630p node
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <8db067d55335dcfb4be9cc6e5f561129b1fd5863.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

To preserve by-address-per-group sort order.

Fixes: 0f6d237cafda2e06 ("arm64: dts: renesas: r8a7795: add ccree to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c417d4a098df..abb361e41ef6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -525,15 +525,6 @@
 			status = "disabled";
 		};
 
-		arm_cc630p: crypto at e6601000 {
-			compatible = "arm,cryptocell-630p-ree";
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x0 0xe6601000 0 0x1000>;
-			clocks = <&cpg CPG_MOD 229>;
-			resets = <&cpg 229>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-		};
-
 		i2c3: i2c at e66d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -805,6 +796,15 @@
 			status = "disabled";
 		};
 
+		arm_cc630p: crypto at e6601000 {
+			compatible = "arm,cryptocell-630p-ree";
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0xe6601000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 229>;
+			resets = <&cpg 229>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7795",
 				     "renesas,rcar-dmac";
-- 
2.11.0
