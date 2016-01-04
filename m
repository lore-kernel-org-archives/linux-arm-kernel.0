From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:27:45 +1100
Subject: [PATCH v2 10/13] ARM: shmobile: gose: enable sound DMA support via
 BUSIF in device tree
In-Reply-To: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
References: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1451946468-20499-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA transfer to/from SSIU in gose/r8a7791 device tree.

     DMA
[MEM] -> [SSIU] -> [SSI]

     DMA
[MEM] <- [SSIU] <- [SSI]

Based on similar work for the r8a7791/koelsch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 0ab0abb9f889..4a7048d676c8 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -321,11 +321,6 @@
 	};
 };
 
-&ssi0 {
-	no-busif;
-};
-
 &ssi1 {
-	no-busif;
 	shared-pin;
 };
-- 
2.1.4
