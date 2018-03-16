From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:26 +0100
Subject: [PATCH 07/52] ARM: dts: porter: Fix HDMI output routing
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <d4b78db6ac3e084e2bdc57d5518bd247c727f396.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The HDMI encoder is connected to the RGB output of the DU, which is
port at 0, not port at 1. Fix the incorrect DT description.

Fixes: c5af8a4248d3 ("ARM: dts: porter: add DU DT support")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index eb374956294f..9a02d03b23c2 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -425,7 +425,7 @@
 		      "dclkin.0", "dclkin.1";
 
 	ports {
-		port at 1 {
+		port at 0 {
 			endpoint {
 				remote-endpoint = <&adv7511_in>;
 			};
-- 
2.11.0
