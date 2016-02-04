From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:25 +0100
Subject: [PATCH 31/70] ARM: dts: gose: enable sound DMA support in device tree
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <96c1b8d8507102759c1e232f371ff333811ccdd9.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA transfer to/from SSI in r8a7793/gose device tree.

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Based on similar work for the r8a7791/koelsch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 395ea63746ac..a4b2dcb8e73d 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -408,10 +408,10 @@
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
2.7.0.rc3.207.g0ac5344
