From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 16:46:03 +0200
Subject: [PATCH v2 8/9] openrisc: drop wrongly typed definition of
 page_to_virt()
In-Reply-To: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459349164-27175-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To align with generic code and other architectures that expect the macro
page_to_virt to produce an expression whose type is 'void*', drop the
arch specific definition, which is never referenced anyway.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/openrisc/include/asm/page.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index e613d3673034..35bcb7cd2cde 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -81,8 +81,6 @@ typedef struct page *pgtable_t;
 
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
-#define page_to_virt(page) \
-	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
 #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-- 
2.5.0
