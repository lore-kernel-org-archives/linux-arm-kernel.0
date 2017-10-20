From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:04 +0200
Subject: [PATCH 01/31] arm64: dts: renesas: salvator-common: drop
 "avb_phy_int" from avb_pins
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <86b93a2dff65ab6e22ffd28bb132a2c3970b6e68.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the Ethernet AVB driver doesn't support AVB_PHY_INT handling
and it will be handled by a phy driver as a gpio pin, this patch
removes the "avb_phy_int" from the avb_pins node.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 7d73a4da2681 ("arm64: dts: r8a7795: salvator-x: Set drive-strength for ravb pins")
Fixes: 4903987033be ("arm64: dts: r8a7796: salvator-x: Set drive-strength for ravb pins")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 4786c67b5e65..99d8180c71f7 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -371,8 +371,7 @@
 
 	avb_pins: avb {
 		mux {
-			groups = "avb_link", "avb_phy_int", "avb_mdc",
-				 "avb_mii";
+			groups = "avb_link", "avb_mdc", "avb_mii";
 			function = "avb";
 		};
 
-- 
2.11.0
