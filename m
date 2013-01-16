From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 16 Jan 2013 20:19:22 +0530
Subject: [PATCH] ARM: mm: Fix missing XN flag for for MT_MEMORY_SO
Message-ID: <1358347762-14682-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8fb54284ba6a {ARM: mm: Add strongly ordered descriptor support}
added XN flag at section level but missed it at PTE level.

Fix it by adding the L_PTE_XN to MT_MEMORY_SO PET descriptor.

Cc: Russell King <linux@arm.linux.org.uk>

Reported-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f06102..ce328c7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -283,7 +283,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_SO] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_MT_UNCACHED,
+				L_PTE_MT_UNCACHED | L_PTE_XN,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
 				PMD_SECT_UNCACHED | PMD_SECT_XN,
-- 
1.7.9.5
