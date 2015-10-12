From: james.morse@arm.com (James Morse)
Date: Mon, 12 Oct 2015 14:17:37 +0100
Subject: [PATCH 5/6] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <1444655858-26083-1-git-send-email-james.morse@arm.com>
References: <1444655858-26083-1-git-send-email-james.morse@arm.com>
Message-ID: <1444655858-26083-6-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
linux/const.h where this is defined. This produces build warnings when only
asm/page.h is included by asm code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 7d9c7e4a424b..74f67d049a63 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
+#include <linux/const.h>
+
 /* PAGE_SHIFT determines the page size */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PAGE_SHIFT		16
-- 
2.1.4
