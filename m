From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 14 May 2014 10:24:25 +0200
Subject: [PATCH] [RESEND] ARM: remove last use of CONFIG_CPU_ARM710
In-Reply-To: <1364507176.1345.45.camel@x61.thuisdomein>
References: <1364507176.1345.45.camel@x61.thuisdomein>
Message-ID: <1400055865.31197.4.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for ARM710 CPUs was removed in v3.5. Now remove the last code
depending on its Kconfig macro.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
First submitted in March 2103. Still untested. Please note that
cpu_arm7_data_abort was also removed in v3.5.

 arch/arm/include/asm/glue-df.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index 6b70f1b46a6e..04e18b656659 100644
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
 #ifdef CONFIG_CPU_ABRT_EV4
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
-- 
1.9.0
