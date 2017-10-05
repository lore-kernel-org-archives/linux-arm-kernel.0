From: allen.pais@oracle.com (Allen Pais)
Date: Thu,  5 Oct 2017 17:46:55 +0530
Subject: [PATCH] arm64: use vma_pages helper
Message-ID: <1507205815-5204-1-git-send-email-allen.pais@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Use vma_pages function on vma object instead of explicit computation.
  This is a clean up patch.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/arm64/mm/dma-mapping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 614af88..5f62090 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -303,8 +303,7 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
 	int ret = -ENXIO;
-	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
-					PAGE_SHIFT;
+	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 
-- 
1.9.1
