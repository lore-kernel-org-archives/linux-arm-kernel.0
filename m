From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 25 Jun 2014 08:41:45 +0100
Subject: [PATCH] arm64: mm: Fix horrendous config typo
Message-ID: <1403682105-7919-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The define ARM64_64K_PAGES is tested for rather than
CONFIG_ARM64_64K_PAGES. Correct that typo here.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5797020..e0ccceb 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -292,7 +292,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
 
-#ifdef ARM64_64K_PAGES
+#ifdef CONFIG_ARM64_64K_PAGES
 #define pud_sect(pud)		(0)
 #else
 #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
-- 
1.9.3
