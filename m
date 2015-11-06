From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 6 Nov 2015 06:39:02 +0000
Subject: [PATCH 08/12 v6] arm64: renesas: salvator-x: Sound SSI DMA support
 via BUSIF
In-Reply-To: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <8737wjk56d.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer to/from SSIU

     DMA
[MEM] -> [SSIU] -> [SSI]

     DMA
[MEM] <- [SSIU] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5 -> v6

 - no change

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 6f4217f..e57a9e5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -142,12 +142,7 @@
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
1.9.1
