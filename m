From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 14 May 2014 11:59:47 +0200
Subject: [PATCH] ARM: nommu: remove unused KTHREAD_SIZE #define
Message-ID: <1400061587.31197.18.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) A very similar commit is 10b5aabddd1e ("[PATCH]
include/asm-h8300/page.h: remove unused KTHREAD_SIZE #define"). I found
that commit by looking into the history of the unloved
CONFIG_SMALL_TASKS macro. References to it were added to (a few places
in) the tree, starting with v2.5.46. But I haven't found evidence that
it was ever defined.

 arch/arm/include/asm/page-nommu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
index d1b162a18dcb..58da8b22cf10 100644
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
 #define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
 #define free_user_page(page, addr)	free_page(addr)
 
-- 
1.9.0
