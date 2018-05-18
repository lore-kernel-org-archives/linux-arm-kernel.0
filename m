From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:28 +0200
Subject: [PATCH 006/102] arm64: dts: renesas: r8a77965: add USB 3.0 host node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <e3cee8902e79705526c75efd5187081347c76ecf.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB 3.0 host node for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index ac74413d006f..a34b80a0f304 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -956,8 +956,14 @@
 		};
 
 		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a77965",
+				     "renesas,rcar-gen3-xhci";
 			reg = <0 0xee000000 0 0xc00>;
-			/* placeholder */
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
 		};
 
 		wdt0: watchdog at e6020000 {
-- 
2.11.0
