From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 17 Sep 2015 12:38:08 +0300
Subject: [PATCH v6 2/6] arm64: move PGD_SIZE definition to pgalloc.h
In-Reply-To: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1442482692-6416-3-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used by KASAN latter.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgalloc.h | 1 +
 arch/arm64/mm/pgd.c              | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 7642056..c150539 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -27,6 +27,7 @@
 #define check_pgt_cache()		do { } while (0)
 
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
+#define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 71ca104..cb3ba1b 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -28,8 +28,6 @@
 
 #include "mm.h"
 
-#define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
-
 static struct kmem_cache *pgd_cache;
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
-- 
2.4.6
