From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 15:29:57 +0200
Subject: [PULL 04/29] arm64: Introduce pmd_thp_or_huge
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1462973422-10021-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add a helper to determine if a given pmd represents a huge page
either by hugetlb or thp, as we have for arm. This will be used
by KVM MMU code.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 989fef1..dda4aa9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -290,6 +290,8 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
 
+#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
-- 
2.1.2.330.g565301e.dirty
