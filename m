From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 28 Mar 2013 22:46:16 +0100
Subject: [PATCH] ARM: remove last use of CONFIG_CPU_ARM710
Message-ID: <1364507176.1345.45.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for ARM710 CPUs was removed in v3.5. Now remove the last code
depending on its Kconfig macro.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Note that cpu_arm7_data_abort was also removed.

 arch/arm/include/asm/glue-df.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index 8cacbcd..75e6908 100644
--- a/arch/arm/include/asm/glue-df.h
+++ b/arch/arm/include/asm/glue-df.h
@@ -31,14 +31,6 @@
 #undef CPU_DABORT_HANDLER
 #undef MULTI_DABORT
 
-#if defined(CONFIG_CPU_ARM710)
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER cpu_arm7_data_abort
-# endif
-#endif
-
 #ifdef CONFIG_CPU_ABRT_LV4T
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
-- 
1.7.11.7
