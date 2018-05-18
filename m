From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:24 +0200
Subject: [PATCH 002/102] arm64: dts: renesas: r8a77965: add usb3_phy node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <7a4a541eed654d62f82146f71b8aed869254e9ad.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds usb3_phy node for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index d498274fa0f3..abb4d4dcc0ed 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -868,9 +868,16 @@
 		};
 
 		usb3_phy0: usb-phy at e65ee000 {
+			compatible = "renesas,r8a77965-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
 			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
 			#phy-cells = <0>;
-			/* placeholder */
+			status = "disabled";
 		};
 
 		usb3_peri0: usb at ee020000 {
-- 
2.11.0
