From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:23 +0900
Subject: [PATCH 3/3] arm64: dts: r8a7795: Use USB3.0 fallback compatibility
 string
In-Reply-To: <cover.1459731817.git.horms+renesas@verge.net.au>
References: <cover.1459731817.git.horms+renesas@verge.net.au>
Message-ID: <81ae0ac31bb90baef10850fdfdc2a9f72f36aa6f.1459731817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7795 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a88f8d840c48..868c10eaea48 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -982,7 +982,7 @@
 		};
 
 		xhci0: usb at ee000000 {
-			compatible = "renesas,xhci-r8a7795";
+			compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
 			reg = <0 0xee000000 0 0xc00>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
@@ -991,7 +991,7 @@
 		};
 
 		xhci1: usb at ee0400000 {
-			compatible = "renesas,xhci-r8a7795";
+			compatible = "renesas,xhci-r8a7795", "renesas,rcar-gen3-xhci";
 			reg = <0 0xee040000 0 0xc00>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 327>;
-- 
2.1.4
