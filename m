From: bahadir@l4dev.org (Bahadir Balban)
Date: Fri, 18 Dec 2009 14:54:37 +0200
Subject: Remove redundant vma_vm_flags from v7wbi_flush_user_tlb_range
Message-ID: <4B2B7B8D.9030403@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

You don't seem to be testing for VM_EXEC as in v6 version, so 
vma_vm_flags seem redundant. What do you think?


---
  arch/arm/mm/tlb-v7.S |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index a26a605..0cb1848 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -40,7 +40,6 @@ ENTRY(v7wbi_flush_user_tlb_range)
  	asid	r3, r3				@ mask ASID
  	orr	r0, r3, r0, lsl #PAGE_SHIFT	@ Create initial MVA
  	mov	r1, r1, lsl #PAGE_SHIFT
-	vma_vm_flags r2, r2			@ get vma->vm_flags
  1:
  #ifdef CONFIG_SMP
  	mcr	p15, 0, r0, c8, c3, 1		@ TLB invalidate U MVA (shareable)
-- 
1.5.4.3


-- 
Bahadir Balban
