From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jan 2016 12:18:28 +0000
Subject: [PATCH] arm64: asm: Explicitly include linux/personality.h in
 asm/page.h
Message-ID: <1453983508-20410-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/page.h uses READ_IMPLIES_EXEC from linux/personality.h but does not
explicitly include it causing build failures in -next where whatever was
causing it to be implicitly included has changed to remove that
inclusion.  Add an explicit inclusion to fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 9b2f5a9d019d..9553c39e0655 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
+#include <linux/personality.h>
+
 /* PAGE_SHIFT determines the page size */
 /* CONT_SHIFT determines the number of pages which can be tracked together  */
 #ifdef CONFIG_ARM64_64K_PAGES
-- 
2.7.0.rc3
