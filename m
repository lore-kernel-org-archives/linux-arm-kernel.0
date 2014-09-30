From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:26 -0700
Subject: [PATCH 1/5] ARM: include missing cp15.h header
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1412040930-16864-2-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of this commit:

  commit 39792c7cf3111d69dc4aa0923859d8b929e9039f
  ARM: 7861/1: cacheflush: consolidate single-CPU ARMv7 cache disabling code

cacheflush.h now utilizes the CR_C macro from cp15.h. Let's include it.

This also means several users of v7_exit_coherency_flush() no longer
have to include cp15.h directly when they don't directly use any #defines
from it.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/include/asm/cacheflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 79ecb4f34ffb..866e229d3129 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,6 +16,7 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
+#include <asm/cp15.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
-- 
1.9.1
