From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:15 +0200
Subject: [PULL 07/50] arm64/kvm: remove unused stub functions
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-8-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that 32-bit KVM no longer performs cache maintenance for page table
updates, we no longer need empty stubs for arm64. Remove them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b6bb834..8f99ab6 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -166,12 +166,6 @@ void kvm_clear_hyp_idmap(void);
 #define	kvm_set_pte(ptep, pte)		set_pte(ptep, pte)
 #define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
 
-static inline void kvm_clean_pgd(pgd_t *pgd) {}
-static inline void kvm_clean_pmd(pmd_t *pmd) {}
-static inline void kvm_clean_pmd_entry(pmd_t *pmd) {}
-static inline void kvm_clean_pte(pte_t *pte) {}
-static inline void kvm_clean_pte_entry(pte_t *pte) {}
-
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= PTE_S2_RDWR;
-- 
2.9.0
