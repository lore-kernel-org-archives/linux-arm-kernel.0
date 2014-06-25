From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:25 +0900
Subject: [PATCH 13/14] ARM: shmobile: rcar-gen2: update call to
 dma_contiguous_reserve_area
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <14a5e926141f9c37bdaa0220169489e782220ee1.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Stehl? <vincent.stehle@laposte.net>

Commit 5ea3b1b2f8ad 'cma: add placement specifier for "cma=" kernel parameter'
adds a new 'fixed' parameter to dma_contiguous_reserve_area(). Update
rcar_gen2_reserve() accordingly.

This fixes the following compilation error:

  arch/arm/mach-shmobile/setup-rcar-gen2.c: In function ?rcar_gen2_reserve?:
  arch/arm/mach-shmobile/setup-rcar-gen2.c:182:10: error: too few arguments to function ?dma_contiguous_reserve_area?

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
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
2.0.0.rc2
