From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:20:04 +0900
Subject: [PATCH 13/25] ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
Message-ID: <59bd80f145e21ed9eca2648d8c59b1983a1bd74f.1415755881.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7790-lager.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 93630d0..0634fff 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -575,11 +575,6 @@
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
2.1.1
