From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed,  7 Oct 2015 12:00:22 -0500
Subject: [PATCH 4/7] arm64: Default kernel pages should be contiguous
In-Reply-To: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1444237225-13802-5-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default page attributes for a PMD being broken should have the CONT bit
set. Create a new definition for an early boot range of PTE's that are
contiguous.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index cc19ec1..a1bcd64 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -72,6 +72,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
+#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | \
+					 PTE_WRITE | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
-- 
2.4.3
