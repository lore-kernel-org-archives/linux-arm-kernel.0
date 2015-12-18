From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 18 Dec 2015 17:01:46 +0000
Subject: [PATCH 1/3] iommu/dma: Add some missing #includes
Message-ID: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma-iommu.c was naughtily relying on an implicit transitive #include of
linux/vmalloc.h, which is apparently not present on some architectures.
Add that, plus a couple more headers for other functions which are used
similarly.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Hi Joerg,

here are a couple more minor fixes for some obscure subtleties in the
common DMA code. I see I've just missed the rc5 fixes pull, but I hope
you can pick these up for rc6 (unless of course you're also just about
to disappear for 2 weeks like I am).

Thanks,
Robin.


 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 427fdc1..982e716 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,10 +21,13 @@
 
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/vmalloc.h>
 
 int iommu_dma_init(void)
 {
-- 
1.9.1
