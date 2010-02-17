From: walsimou@walsimou.com (Abdoulaye Walsimou Gaye)
Date: Wed, 17 Feb 2010 17:27:51 +0100
Subject: [PATCH] ARM: Fix build error for arm1026ej-s processor
Message-ID: <1266424071-24053-1-git-send-email-walsimou@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the below build error for arm1026ej-s processor (IntegratorCP/arm1026ej-s board).
  CC      init/main.o
In file included from include/linux/highmem.h:8,
                 from include/linux/pagemap.h:10,
                 from include/linux/mempolicy.h:62,
                 from init/main.c:52:
arch/arm/include/asm/cacheflush.h:134:2: error: #error Unknown cache maintainence model
make[1]: *** [init/main.o] Erreur 1
make: *** [init] Erreur 2

Signed-off-by: Abdoulaye Walsimou Gaye <walsimou@walsimou.com>
---
 arch/arm/include/asm/cacheflush.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index c77d2fa..1832227 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -42,7 +42,8 @@
 #endif
 
 #if defined(CONFIG_CPU_ARM920T) || defined(CONFIG_CPU_ARM922T) || \
-    defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020)
+    defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020) || \
+     defined(CONFIG_CPU_ARM1026)
 # define MULTI_CACHE 1
 #endif
 
-- 
1.6.3.3
