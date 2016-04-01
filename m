From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:34 +0100
Subject: [PATCH v7 10/16] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1459529620-22150-11-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
linux/const.h where this is defined. This produces build warnings when only
asm/page.h is included by asm code.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index ae615b9d9a55..17b45f7d96d3 100644
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
2.8.0.rc3
