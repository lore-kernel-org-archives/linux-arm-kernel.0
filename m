From: zi.yan@sent.com (Zi Yan)
Date: Thu, 26 Apr 2018 10:27:57 -0400
Subject: [RFC PATCH 2/9] arm: mm: migrate: add pmd swap entry to support thp
 migration.
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Message-ID: <20180426142804.180152-3-zi.yan@sent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mm at kvack.org
---
 arch/arm/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a757401129f9..d4b35514e96a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -347,7 +347,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)	((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
+#define __swp_entry_to_pmd(swp)	((pmd_t) { (swp).val })
 
 /*
  * It is an error for the kernel to have more swap files than we can
-- 
2.17.0
