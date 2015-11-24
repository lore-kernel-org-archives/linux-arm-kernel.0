From: mkarthi3@visteon.com (Mutharaju, Prasanna (P.))
Date: Tue, 24 Nov 2015 07:38:12 +0000
Subject: [PATCH] ARM: MM: Simplify using vma_pages function
Message-ID: <20151124073805.GA23513@jci-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Karthik <mkarthi3@visteon.com>

Use vma_pages function on vma object instead of explicit computation.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ad4eb2d..513e213 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -694,7 +694,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
-	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
-- 
1.9.1
