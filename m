From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 17:05:56 +0100
Subject: [PATCH 2/2] arm64/kvm: remove unused stub functions
In-Reply-To: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
References: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1472573156-30414-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that 32-bit KVM no longer performs cache maintenance for page table
updates, we no longer need empty stubs for arm64. Remove them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
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
1.9.1
