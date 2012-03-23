From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 22 Mar 2012 22:41:52 -0700 (PDT)
Subject: [PATCH] ARM: fixup section mismatch warning for alloc_init_pud()
Message-ID: <87398zswkj.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixup below warning

WARNING: arch/arm/mm/built-in.o(.text+0x2320):
Section mismatch in reference from the function alloc_init_pud()
to the function .init.text:alloc_init_section()
The function alloc_init_pud() references
the function __init alloc_init_section().
This is often because alloc_init_pud lacks a __init
annotation or the annotation of alloc_init_section is wrong.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mm/mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 94c5a0c..95a8098 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -616,7 +616,7 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 	}
 }
 
-static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
+static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long phys, const struct mem_type *type)
 {
 	pud_t *pud = pud_offset(pgd, addr);
-- 
1.7.5.4
