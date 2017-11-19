From: colin.king@canonical.com (Colin King)
Date: Sun, 19 Nov 2017 21:17:19 +0000
Subject: [PATCH] arm: dma-mapping: use vma_pages helper function
Message-ID: <20171119211719.16859-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Use the vma_pages helper function on vma instead of an explicit
calculation.

Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ada8eb206a90..ec0f277d1d4d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -831,7 +831,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 unsigned long attrs)
 {
 	int ret;
-	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
-- 
2.14.1
