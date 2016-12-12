From: okaratas@member.fsf.org (Ozgur Karatas)
Date: Mon, 12 Dec 2016 12:46:45 +0200
Subject: [PATCH 1/1] Fixed checkpatch error to mmu.c
Message-ID: <962731481539605@web19g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I tested to mmu.c and I have fixed to some errors.

mmu.c:510: ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Ozgur Karatas <okaratas@member.fsf.org>
---
arch/arm/kvm/mmu.c                       |  2 +-

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index a5265ed..a83cf47 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -507,7 +507,7 @@ void free_hyp_pgds(void)
 		unmap_hyp_range(hyp_pgd, hyp_idmap_start, PAGE_SIZE);
 		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
 			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);
-		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
+		for (addr = VMALLOC_START; is_vmalloc_addr((void *)addr); addr += PGDIR_SIZE)
 			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);

-- 
2.1.4
