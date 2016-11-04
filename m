From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:27 +0100
Subject: [PATCH 28/29] ARM: dts: r8a7779: marzen: Configure pinmuxing for the
 DU0 input clock
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <8698d83dcf1b348eb54bcd1d52b8c636d8d7d494.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

DU0 uses an externally provided clock, but the corresponding pin isn't
correctly muxed. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 541678df90a9..676151b70185 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -170,7 +170,7 @@
 
 	du_pins: du {
 		du0 {
-			groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
+			groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0", "du0_clk_in";
 			function = "du0";
 		};
 		du1 {
-- 
2.7.0.rc3.207.g0ac5344
