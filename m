From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 May 2012 01:20:49 +0200
Subject: [PATCH] ARM: Make consistent_base static
Message-ID: <1338333649-26022-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable isn't used outside of its compilation unit, make it static.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I've spent too much time trying to understand how the consistent DMA memory
region was managed, tracking the users of the consistent_base variable only to
find out it wasn't used outside of dma-mapping.c. Let's save time for the next
developer who will check the code.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..3d368d3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -130,7 +130,7 @@ static pte_t **consistent_pte;
 
 #define DEFAULT_CONSISTENT_DMA_SIZE SZ_2M
 
-unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
+static unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
 
 void __init init_consistent_dma_size(unsigned long size)
 {
-- 
Regards,

Laurent Pinchart
