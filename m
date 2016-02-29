From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Feb 2016 15:44:43 +0100
Subject: [PATCH v2 8/9] openrisc: drop wrongly typed definition of
 page_to_virt()
In-Reply-To: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456757084-1078-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To align with generic code and other architectures that expect the macro
page_to_virt to produce an expression whose type is 'void*', drop the
arch specific definition, which is never referenced anyway.

Cc: linux-mm at kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux at lists.openrisc.net
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/openrisc/include/asm/page.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 108906f991d6..1976f7272b1f 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -84,8 +84,6 @@ typedef struct page *pgtable_t;
 
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
-#define page_to_virt(page) \
-	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
 #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-- 
2.5.0
