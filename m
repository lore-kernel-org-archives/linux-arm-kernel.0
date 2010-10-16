From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 16 Oct 2010 20:06:30 +0200
Subject: [PATCH 1/2] ARM: fixup TCM memory types
Message-ID: <1287252390-13303-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After Santosh's fixup of the generic MT_MEMORY and
MT_MEMORY_NONCACHED I add this fix to the TCM memory types.
The main change is that the ITCM memory is L_PTE_WRITE and
DOMAIN_KERNEL which works just fine. The changed to the DTCM
is just cosmetic to fit with surrounding code.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rickard Andersson <rickard.andersson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/mmu.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 72cc529..4b7a690 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -266,17 +266,17 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_DTCM] = {
-		.prot_pte	= L_PTE_PRESENT | L_PTE_YOUNG |
-		                  L_PTE_DIRTY | L_PTE_WRITE,
-		.prot_l1	= PMD_TYPE_TABLE,
-		.prot_sect	= PMD_TYPE_SECT | PMD_SECT_XN,
-		.domain		= DOMAIN_KERNEL,
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_WRITE,
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
+		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_ITCM] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_EXEC,
+				L_PTE_WRITE | L_PTE_EXEC,
 		.prot_l1   = PMD_TYPE_TABLE,
-		.domain    = DOMAIN_IO,
+		.domain    = DOMAIN_KERNEL,
 	},
 };
 
-- 
1.6.3.3
