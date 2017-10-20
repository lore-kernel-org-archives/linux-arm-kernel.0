From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:06 +0200
Subject: [PATCH 03/31] arm64: dts: renesas: r8a77995: draak: drop
 "avb_phy_int" from avb_pins
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <12bb361979b523bbae00542c17cda8f3f0048860.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the Ethernet AVB driver doesn't support AVB_PHY_INT handling
and it will be handled by a phy driver as a gpio pin, this patch
removes the "avb_phy_int" from the avb_pins node.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Fixes: 4503b50eac08 ("arm64: dts: renesas: r8a77995: draak: enable EthernetAVB")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 96b7ff5cc321..fac58be83383 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -41,8 +41,7 @@
 &pfc {
 	avb0_pins: avb {
 		mux {
-			groups = "avb0_link", "avb0_phy_int", "avb0_mdc",
-				 "avb0_mii";
+			groups = "avb0_link", "avb0_mdc", "avb0_mii";
 			function = "avb0";
 		};
 	};
-- 
2.11.0
