From: andr2000@gmail.com (Oleksandr Andrushchenko)
Date: Tue, 17 Jan 2017 17:23:53 +0200
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
Message-ID: <1484666633-1753-1-git-send-email-andr2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>

Fix parameter name for __page_to_voff, to match its definition.
There are other callers of page_to_virt which do not
declare 'page'.

Fixes: 3fa72fe9c614 ("arm64: mm: fix __page_to_voff definition")
Signed-off-by: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index bfe632808d77..90c39a662379 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -222,7 +222,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #else
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
-#define __page_to_voff(page)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
+#define __page_to_voff(kaddr)	(((u64)(kaddr) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
 
 #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
-- 
2.7.4
