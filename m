From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:05 +0200
Subject: [PATCH 02/31] arm64: dts: renesas: ulcb: drop "avb_phy_int" from
 avb_pins
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <bc04ba36fb1b6c7ebe1df6011da8679e2a5b90bf.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the Ethernet AVB driver doesn't support AVB_PHY_INT handling
and it will be handled by a phy driver as a gpio pin, this patch
removes the "avb_phy_int" from the avb_pins node.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 133ace3f3804 ("arm64: dts: ulcb: Set drive-strength for ravb pins")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index dfec9072718b..1a5f15ae531f 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -254,8 +254,7 @@
 
 	avb_pins: avb {
 		mux {
-			groups = "avb_link", "avb_phy_int", "avb_mdc",
-				 "avb_mii";
+			groups = "avb_link", "avb_mdc", "avb_mii";
 			function = "avb";
 		};
 
-- 
2.11.0
