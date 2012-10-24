From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 24 Oct 2012 14:09:14 +0900
Subject: [PATCH] ARM: dma-mapping: fix build warning in __dma_alloc()
Message-ID: <000f01cdb1a5$b6409b60$22c1d220$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build warning in __dma_alloc() as below:

arch/arm/mm/dma-mapping.c: In function '__dma_alloc':
arch/arm/mm/dma-mapping.c:653:29: warning: 'page' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 477a2d2..58bc3e4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -610,7 +610,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 
 #ifdef CONFIG_DMA_API_DEBUG
-- 
1.7.1
