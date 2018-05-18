From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:29 +0200
Subject: [PATCH 007/102] arm64: dts: renesas: r8a77965: add USB 3.0 peripheral
 node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <3a7dc06d833bd88f26c66fb16f56d93771cd4c2f.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB 3.0 peripheral node for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index a34b80a0f304..6f748e94a901 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -951,8 +951,14 @@
 		};
 
 		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a77965-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
 			reg = <0 0xee020000 0 0x400>;
-			/* placeholder */
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
 		};
 
 		xhci0: usb at ee000000 {
-- 
2.11.0
