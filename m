From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 May 2012 15:13:52 +0200
Subject: [PATCHv10 02/11] ARM: dma-mapping: use dma_mmap_from_coherent()
In-Reply-To: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
References: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1337260441-8121-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..7ec0863 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -401,6 +401,9 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long user_size, kern_size;
 	struct arm_vmregion *c;
 
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
 	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
 	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
-- 
1.7.10.1
