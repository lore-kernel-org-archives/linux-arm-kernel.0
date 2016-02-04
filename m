From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:27 +0100
Subject: [PATCH 33/70] ARM: dts: gose: enable sound DMA support via SRC in
 device tree
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <d2cde3b6103678a4f3d2079af744937dfc9c4104.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA transfer to/from SRC in r8a7793/gose device tree.

     DMA      DMApp
[MEM] -> [SRC] -> [SSIU] -> [SSI]

     DMA      DMApp
[MEM] <- [SRC] <- [SSIU] <- [SSI]

Current sound driver is supporting
SSI/SRC random connection.
So, this patch is tring
SSI0 -> SRC2
SSI1 <- SRC3

Based on similar work for the r8a7791/koeslch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 81bfe9484bbc..17c87fe0944f 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -401,8 +401,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0>;
-			capture  = <&ssi1>;
+			playback = <&ssi0 &src2>;
+			capture  = <&ssi1 &src3>;
 		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
