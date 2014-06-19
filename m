From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 19 Jun 2014 11:31:10 +0200
Subject: [PATCH linux-next] ARM: shmobile: rcar-gen2: update call to
 dma_contiguous_reserve_area
Message-ID: <1403170270-17877-1-git-send-email-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5ea3b1b2f8ad 'cma: add placement specifier for "cma=" kernel parameter'
adds a new 'fixed' parameter to dma_contiguous_reserve_area(). Update
rcar_gen2_reserve() accordingly.

This fixes the following compilation error:

  arch/arm/mach-shmobile/setup-rcar-gen2.c: In function ?rcar_gen2_reserve?:
  arch/arm/mach-shmobile/setup-rcar-gen2.c:182:10: error: too few arguments to function ?dma_contiguous_reserve_area?

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---

Hi,

This can be seen with linux next-20140619 and e.g. arm allmodconfig.

Best regards,

V.

 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 73fb2a6..42d5b43 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -179,6 +179,6 @@ void __init rcar_gen2_reserve(void)
 #ifdef CONFIG_DMA_CMA
 	if (mrc.size)
 		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
-					    &rcar_gen2_dma_contiguous);
+					    &rcar_gen2_dma_contiguous, true);
 #endif
 }
-- 
2.0.0
