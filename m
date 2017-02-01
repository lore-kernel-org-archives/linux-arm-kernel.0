From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  1 Feb 2017 22:29:22 +0900
Subject: [PATCH 1/2] ARM: cache-uniphier: include <linux/errno.h> instead of
 <linux/types.h>
Message-ID: <1485955762-4936-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing in this header file depends on <linux/types.h>.
Rather, <linux/errno.h> should be included for -ENODEV.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 4.10-rc1


 arch/arm/include/asm/hardware/cache-uniphier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/cache-uniphier.h b/arch/arm/include/asm/hardware/cache-uniphier.h
index eaa60da..0ef42ae 100644
--- a/arch/arm/include/asm/hardware/cache-uniphier.h
+++ b/arch/arm/include/asm/hardware/cache-uniphier.h
@@ -16,7 +16,7 @@
 #ifndef __CACHE_UNIPHIER_H
 #define __CACHE_UNIPHIER_H
 
-#include <linux/types.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_CACHE_UNIPHIER
 int uniphier_cache_init(void);
-- 
2.7.4
