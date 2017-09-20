From: thomas@m3y3r.de (Thomas Meyer)
Date: Thu, 21 Sep 2017 00:29:36 +0200
Subject: [PATCH 1/7] ARM: dma-mapping: Cocci spatch "vma_pages"
In-Reply-To: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1505946334393-1455306870-1-diffsplit-thomas@m3y3r.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use vma_pages function on vma object instead of explicit computation.
Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -846,7 +846,7 @@ static int __arm_dma_mmap(struct device
 		 unsigned long attrs)
 {
 	int ret;
-	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
