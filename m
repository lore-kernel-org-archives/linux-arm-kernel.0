From: jeremy.lefaure@lse.epita.fr (=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=)
Date: Mon, 12 Jun 2017 13:09:33 -0400
Subject: [PATCH 1/2] arm: nommu: remove unused KTHREAD_SIZE definition
Message-ID: <20170612170937.2969-1-jeremy.lefaure@lse.epita.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I didn't find any use of this macro in the current kernel tree (with git
grep). KTHREAD_SIZE is no longer used for a very very long time. So
let's remove this definition.

Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
---
 arch/arm/include/asm/page-nommu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
index 503f488053de..8f2c47bec375 100644
--- a/arch/arm/include/asm/page-nommu.h
+++ b/arch/arm/include/asm/page-nommu.h
@@ -11,12 +11,6 @@
 #ifndef _ASMARM_PAGE_NOMMU_H
 #define _ASMARM_PAGE_NOMMU_H
 
-#if !defined(CONFIG_SMALL_TASKS) && PAGE_SHIFT < 13
-#define KTHREAD_SIZE (8192)
-#else
-#define KTHREAD_SIZE PAGE_SIZE
-#endif
- 
 #define clear_page(page)	memset((page), 0, PAGE_SIZE)
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 
-- 
2.13.1
