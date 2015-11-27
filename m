From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:50 +0900
Subject: [PATCH 07/15] ARM: shmobile: r8a7791: koelsch: Fix pinmux for HDMI
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <22a1ae361169d74e845fe91912d084191fa7b4a5.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The signals output by the DU to the HDMI transmitter use full 24-bit
RGB. Make sure all pins are properly muxed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 4ec2d1fba7c9..50d7b17c6ebd 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -326,7 +326,7 @@
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
+		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		renesas,function = "du";
 	};
 
-- 
2.1.4
