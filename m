From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:07:41 +0100
Subject: [PATCH 02/14] ARM: LPAE: use phys_addr_t in alloc_init_pud()
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368810473-26070-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

This patch fixes the alloc_init_pud() function to use phys_addr_t instead of
unsigned long when passing in the phys argument.

This is an extension to commit 97092e0c56830457af0639f6bd904537a150ea4a (ARM:
pgtable: use phys_addr_t for physical addresses), which applied similar changes
elsewhere in the ARM memory management code.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..b7ce65a8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -673,7 +673,8 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-	unsigned long end, unsigned long phys, const struct mem_type *type)
+				  unsigned long end, phys_addr_t phys,
+				  const struct mem_type *type)
 {
 	pud_t *pud = pud_offset(pgd, addr);
 	unsigned long next;
-- 
1.8.2.2
