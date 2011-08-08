From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:32 +0100
Subject: [PATCH 12/12] ARM: Remove support for macro CONSISTENT_DMA_SIZE
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-13-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are now no platforms which set this macro.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/mm/dma-mapping.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5b59ce5..50be842 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -129,11 +129,7 @@ static void __dma_free_buffer(struct page *page, size_t size)
  */
 static pte_t **consistent_pte;
 
-#ifdef CONSISTENT_DMA_SIZE
-#define DEFAULT_CONSISTENT_DMA_SIZE CONSISTENT_DMA_SIZE
-#else
 #define DEFAULT_CONSISTENT_DMA_SIZE SZ_2M
-#endif
 
 unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
 
-- 
1.7.2.5
