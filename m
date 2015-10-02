From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:42 -0500
Subject: [PATCH 4/7] arm64: Default kernel pages should be contiguous
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443818865-19846-5-git-send-email-jeremy.linton@arm.com>
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
index d43e1d1..252499e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -76,6 +76,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
+#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | \
+					 PTE_WRITE | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
-- 
2.4.3
