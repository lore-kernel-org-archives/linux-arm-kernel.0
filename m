From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jan 2016 10:42:41 +0000
Subject: [PATCH v4 08/13] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <1453977766-20907-1-git-send-email-james.morse@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
Message-ID: <1453977766-20907-9-git-send-email-james.morse@arm.com>
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
index 9b2f5a9d019d..fbafd0ad16df 100644
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
2.6.2
