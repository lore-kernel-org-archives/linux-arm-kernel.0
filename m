From: neeraju@codeaurora.org (Neeraj Upadhyay)
Date: Fri, 21 Oct 2016 14:28:46 +0530
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
Message-ID: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix parameter name for __page_to_voff, to match its definition.
At present, we don't see any issue, as page_to_virt's caller
declares 'page'.

Fixes: 9f2875912dac ("arm64: mm: restrict virt_to_page() to the linear mapping")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index ba62df8..b71086d 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -217,7 +217,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #else
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
-#define __page_to_voff(kaddr)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
+#define __page_to_voff(page)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
 
 #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
