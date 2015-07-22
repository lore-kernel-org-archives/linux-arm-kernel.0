From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 22 Jul 2015 13:30:35 +0300
Subject: [PATCH v3 3/5] arm64: move PGD_SIZE definition to pgalloc.h
In-Reply-To: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1437561037-31995-4-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used by KASAN latter.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
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
2.4.5
