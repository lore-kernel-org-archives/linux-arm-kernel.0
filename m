From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 31 Jul 2012 19:04:42 -0400
Subject: [PATCH 06/22] ARM: LPAE: use phys_addr_t in alloc_init_pud()
In-Reply-To: <1343775898-28345-1-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
Message-ID: <1343775898-28345-7-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

This patch fixes the alloc_init_pud() function to use phys_addr_t instead of
unsigned long when passing in the phys argument.

This is an extension to commit 97092e0c56830457af0639f6bd904537a150ea4a, which
applied similar changes elsewhere in the ARM memory management code.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cf4528d..226985c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -628,7 +628,8 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
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
