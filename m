From: zi.yan@sent.com (Zi Yan)
Date: Thu, 26 Apr 2018 10:27:58 -0400
Subject: [RFC PATCH 3/9] arm64: mm: migrate: add pmd swap entry to support thp
 migration.
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Message-ID: <20180426142804.180152-4-zi.yan@sent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mm at kvack.org
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e2c27e63cd8..1cdc9d3db2c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -742,7 +742,9 @@ extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)	((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
+#define __swp_entry_to_pmd(swp)	((pmd_t) { (swp).val })
 
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
-- 
2.17.0
