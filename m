From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 12 Jan 2011 18:10:44 +0100
Subject: [PATCH] ARM: fix dma_unmap_sg() documentation
Message-ID: <1294852244-11644-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kerneldoc for this function is at odds with the DMA-API
document, which holds, so fix it.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1b3fc5c..82a093c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -586,7 +586,7 @@ EXPORT_SYMBOL(dma_map_sg);
  * dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
- * @nents: number of buffers to unmap (returned from dma_map_sg)
+ * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  *
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
-- 
1.7.3.2
