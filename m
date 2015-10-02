From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:39 -0500
Subject: [PATCH 1/7] arm64: Add contiguous page flag shifts and constants
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443818865-19846-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the number of pages required to form a contigious range,
as well as some supporting constants.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/page.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 7d9c7e4..33892ef 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -20,14 +20,20 @@
 #define __ASM_PAGE_H
 
 /* PAGE_SHIFT determines the page size */
+/* CONT_SHIFT determines the number of pages which can be tracked together  */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PAGE_SHIFT		16
+#define CONT_SHIFT		5
 #else
 #define PAGE_SHIFT		12
+#define CONT_SHIFT		4
 #endif
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
+#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
+#define CONT_SIZE		(_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
+#define CONT_MASK		(~(CONT_SIZE-1))
+
 /*
  * The idmap and swapper page tables need some space reserved in the kernel
  * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
-- 
2.4.3
