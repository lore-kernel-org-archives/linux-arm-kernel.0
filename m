From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 May 2015 14:46:54 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Fix adv7511 IRQ sensing
In-Reply-To: <cover.1430977471.git.horms+renesas@verge.net.au>
References: <cover.1430977471.git.horms+renesas@verge.net.au>
Message-ID: <12392f5896c9affc03c1ddd95a83c32238862a58.1430977471.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The adv7511 IRQ is low level triggered, not falling edge triggered. The
wrong sense configuration results in no interrupt being triggered at
all, breaking hotplug detection. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Fixes: 83a0731b39f3 ("ARM: shmobile: koelsch: Add DU HDMI output support")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74c3212f1f11..824ddab9c3ad 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -545,7 +545,7 @@
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
2.1.4
