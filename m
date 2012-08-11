From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 10 Aug 2012 21:24:50 -0400
Subject: [PATCH v2 07/22] ARM: LPAE: use phys_addr_t in alloc_init_pud()
In-Reply-To: <1344648306-15619-1-git-send-email-cyril@ti.com>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
Message-ID: <1344648306-15619-8-git-send-email-cyril@ti.com>
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
---
 arch/arm/mm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4c2d045..53eeeb8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -622,7 +622,8 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-	unsigned long end, unsigned long phys, const struct mem_type *type)
+				  unsigned long end, phys_addr_t phys,
+				  const struct mem_type *type)
 {
 	pud_t *pud = pud_offset(pgd, addr);
 	unsigned long next;
-- 
1.7.9.5
