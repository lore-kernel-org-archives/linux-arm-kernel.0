From: hch@lst.de (Christoph Hellwig)
Date: Mon,  5 Nov 2018 13:19:30 +0100
Subject: [PATCH 8/9] csky: don't use GFP_DMA in atomic_pool_init
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Message-ID: <20181105121931.13481-9-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

csky does not implement ZONE_DMA, which means passing GFP_DMA is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 85437b21e045..ad4046939713 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -35,7 +35,7 @@ static int __init atomic_pool_init(void)
 	if (!atomic_pool)
 		BUG();
 
-	page = alloc_pages(GFP_KERNEL | GFP_DMA, get_order(size));
+	page = alloc_pages(GFP_KERNEL, get_order(size));
 	if (!page)
 		BUG();
 
-- 
2.19.1
