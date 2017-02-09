From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:17 +0100
Subject: [PATCH 3/8] mm: cma: Export a few symbols
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2dee6c0baaf08e2c7d48ceb7e97e511c914d0f87.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modules might want to check their CMA pool size and address for debugging
and / or have additional checks.

The obvious way to do this would be through dev_get_cma_area and
cma_get_base and cma_get_size, that are currently not exported, which
results in a build failure.

Export them to prevent such a failure.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/base/dma-contiguous.c | 1 +
 mm/cma.c                      | 2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index e167a1e1bccb..60f5c2591ccd 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -35,6 +35,7 @@
 #endif
 
 struct cma *dma_contiguous_default_area;
+EXPORT_SYMBOL(dma_contiguous_default_area);
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
diff --git a/mm/cma.c b/mm/cma.c
index c960459eda7e..b50245282a18 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -47,11 +47,13 @@ phys_addr_t cma_get_base(const struct cma *cma)
 {
 	return PFN_PHYS(cma->base_pfn);
 }
+EXPORT_SYMBOL(cma_get_base);
 
 unsigned long cma_get_size(const struct cma *cma)
 {
 	return cma->count << PAGE_SHIFT;
 }
+EXPORT_SYMBOL(cma_get_size);
 
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     int align_order)
-- 
git-series 0.8.11
