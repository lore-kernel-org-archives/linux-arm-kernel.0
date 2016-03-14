From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:00 +0000
Subject: [PATCH v15 06/20] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <308036c37af1b541736eefe06919eb1a6156ee42.1457977402.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
linux/const.h where this is defined. This produces build warnings when only
asm/page.h is included by asm code.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index ae615b9..17b45f7 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
+#include <linux/const.h>
+
 /* PAGE_SHIFT determines the page size */
 /* CONT_SHIFT determines the number of pages which can be tracked together  */
 #ifdef CONFIG_ARM64_64K_PAGES
-- 
2.5.0
