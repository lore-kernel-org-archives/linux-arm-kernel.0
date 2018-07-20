From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:33 +0200
Subject: [PATCH 2/9] arm64: dts: renesas: salvator-common: Fix adv7482 decimal
 unit addresses
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <c5a884838ce34681200b5a45b2330177036affd0.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

With recent dtc and W=1:

    ...salvator-x.dtb: Warning (graph_port): /soc/i2c at e66d8000/video-receiver at 70/port at 10: graph node unit address error, expected "a"
    ...salvator-x.dtb: Warning (graph_port): /soc/i2c at e66d8000/video-receiver at 70/port at 11: graph node unit address error, expected "b"

Unit addresses are always hexadecimal (without prefix), while the bases
of reg property values depend on their prefixes.

Fixes: 908001d778eba06e ("arm64: dts: renesas: salvator-common: Add ADV7482 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index ce808d3f9f62..6439d05fd7ec 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -446,7 +446,7 @@
 			};
 		};
 
-		port at 10 {
+		port at a {
 			reg = <10>;
 
 			adv7482_txa: endpoint {
@@ -456,7 +456,7 @@
 			};
 		};
 
-		port at 11 {
+		port at b {
 			reg = <11>;
 
 			adv7482_txb: endpoint {
-- 
2.11.0
