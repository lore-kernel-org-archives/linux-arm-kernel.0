From: thomas@m3y3r.de (Thomas Meyer)
Date: Thu, 21 Sep 2017 00:29:36 +0200
Subject: [PATCH 2/7] arm64: Cocci spatch "vma_pages"
In-Reply-To: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1505946334393-397244072-2-diffsplit-thomas@m3y3r.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use vma_pages function on vma object instead of explicit computation.
Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -303,8 +303,7 @@ static int __swiotlb_mmap_pfn(struct vm_
 			      unsigned long pfn, size_t size)
 {
 	int ret = -ENXIO;
-	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
-					PAGE_SHIFT;
+	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 
