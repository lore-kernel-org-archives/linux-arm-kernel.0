From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:11 +0800
Subject: [PATCH 4/7] ARM: cache: add cputype.h for tauros2
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-4-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mm/cache-tauros2.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 97e2ac8..4b787bb 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/cputype.h>
 #include <asm/hardware/cache-tauros2.h>
 
 
@@ -161,8 +162,6 @@ static void __init disable_l2_prefetch(void)
 
 static inline int __init cpuid_scheme(void)
 {
-	extern int processor_id;
-
 	return !!((processor_id & 0x000f0000) == 0x000f0000);
 }
 
@@ -191,7 +190,6 @@ static inline void __init write_actlr(u32 actlr)
 
 void __init tauros2_init(void)
 {
-	extern int processor_id;
 	char *mode = NULL;
 
 	disable_l2_prefetch();
-- 
1.7.0.4
