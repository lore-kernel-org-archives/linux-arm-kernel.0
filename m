From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 06:38:08 +0000
Subject: [PATCH 07/12] arm64: renesas: salvator-x: Sound SSI DMA support
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87si3u7fnm.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer to/from SSI

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 90ca7fa..9c5fd4a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -143,11 +143,11 @@
 };
 
 &ssi0 {
-	pio-transfer;
+	no-busif;
 };
 
 &ssi1 {
-	pio-transfer;
+	no-busif;
 	shared-pin;
 };
 
-- 
1.9.1
