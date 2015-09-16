From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 16 Sep 2015 14:03:02 -0500
Subject: [PATCH 3/7] arm64: PTE/PMD contiguous bit definition
In-Reply-To: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
References: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1442430186-9083-4-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the bit positions in the PTE and PMD for the
contiguous bit.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 4489cf6..80eeebf 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -55,6 +55,13 @@
 #define SECTION_MASK		(~(SECTION_SIZE-1))
 
 /*
+ * Contiguous page definitions.
+ */
+#define CONT_RANGE		(_AC(1, UL) << CONT_SHIFT)
+#define CONT_RANGE_MASK	((CONT_RANGE-1) << PAGE_SHIFT)
+#define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_RANGE-1))
+
+/*
  * Hardware page table definitions.
  *
  * Level 1 descriptor (PUD).
@@ -83,6 +90,7 @@
 #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
 #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
 #define PMD_SECT_NG		(_AT(pmdval_t, 1) << 11)
+#define PMD_SECT_CONT		(_AT(pmdval_t, 1) << 52)
 #define PMD_SECT_PXN		(_AT(pmdval_t, 1) << 53)
 #define PMD_SECT_UXN		(_AT(pmdval_t, 1) << 54)
 
@@ -105,6 +113,7 @@
 #define PTE_AF			(_AT(pteval_t, 1) << 10) /* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11) /* nG */
 #define PTE_DBM			(_AT(pteval_t, 1) << 51) /* Dirty Bit Mgmt */
+#define PTE_CONT		(_AT(pteval_t, 1) << 52) /* Contiguous range */
 #define PTE_PXN			(_AT(pteval_t, 1) << 53) /* Privileged XN */
 #define PTE_UXN			(_AT(pteval_t, 1) << 54) /* User XN */
 
-- 
2.4.3
