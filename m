From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Nov 2015 20:04:43 +0800
Subject: [PATCH 2/3] arm64: mmu: make split_pud and fixup_executable static
In-Reply-To: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
References: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
Message-ID: <1447329884-1644-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

split_pud and fixup_executable are only called from within mmu.c, so
they can be declared static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c2fa6b5..02306c3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -165,7 +165,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	} while (addr != end);
 }
 
-void split_pud(pud_t *old_pud, pmd_t *pmd)
+static void split_pud(pud_t *old_pud, pmd_t *pmd)
 {
 	unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
 	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ addr);
@@ -447,7 +447,7 @@ static void __init map_mem(void)
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 }
 
-void __init fixup_executable(void)
+static void __init fixup_executable(void)
 {
 #ifdef CONFIG_DEBUG_RODATA
 	/* now that we are actually fully mapped, make the start/end more fine grained */
-- 
2.6.2
