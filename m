From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Jun 2013 18:37:35 -0700
Subject: [PATCH] arm64: Define PTE_TYPE_HUGEPAGE
Message-ID: <1371519455-64998-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTE_TYPE_HUGEPAGE is referenced by pte_huge, but because nobody uses
this macro it doesn't fail yet.  KVM will be using this when 32-bit
support for huge pages is added so add it.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 66367c6..0219523 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -54,6 +54,7 @@
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
 #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
+#define PTE_TYPE_HUGEPAGE	(_AT(pteval_t, 1) << 0)
 #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
-- 
1.8.1.2
