From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 15:30:01 +0200
Subject: [PULL 08/29] kvm-arm: arm: Introduce hyp page table empty checks
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1462973422-10021-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Introduce hyp_pxx_table_empty helpers for checking whether
a given table entry is empty. This will be used explicitly
once we switch to explicit routines for hyp page table walk.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 7d207b4..5522cdd 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -160,7 +160,11 @@ static inline bool kvm_page_empty(void *ptr)
 
 #define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
 #define kvm_pmd_table_empty(kvm, pmdp) kvm_page_empty(pmdp)
-#define kvm_pud_table_empty(kvm, pudp) (0)
+#define kvm_pud_table_empty(kvm, pudp) false
+
+#define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
+#define hyp_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
+#define hyp_pud_table_empty(pudp) false
 
 static inline void *kvm_get_hwpgd(struct kvm *kvm)
 {
-- 
2.1.2.330.g565301e.dirty
