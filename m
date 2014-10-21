From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 20 Oct 2014 17:34:54 -0700
Subject: [PATCH] arm: Drop extra return statement
Message-ID: <1413851694-15908-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 513510ddba9650fc7da456eefeb0ead7632324f6
(common: dma-mapping: introduce common remapping functions)
managed to end up with an extra return statement from the
original patch. Drop it.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c245d90..e890711 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1198,7 +1198,6 @@ __iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
 {
 	return dma_common_pages_remap(pages, size,
 			VM_ARM_DMA_CONSISTENT | VM_USERMAP, prot, caller);
-	return NULL;
 }
 
 /*
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
