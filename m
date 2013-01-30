From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 30 Jan 2013 12:09:11 +0100
Subject: [PATCH] ARM: sync comments about available data abort models with the
 code
Message-ID: <1359544151-26744-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it bring both in the same increasing order.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

Jonny critizised that I didn't update the comment for my new entry. I
suggest to fix the already existing issues first.

Best regards
Uwe

 arch/arm/include/asm/glue-df.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
index 8cacbcd..b6e9f2c 100644
--- a/arch/arm/include/asm/glue-df.h
+++ b/arch/arm/include/asm/glue-df.h
@@ -18,12 +18,12 @@
  *	================
  *
  *	We have the following to choose from:
- *	  arm6          - ARM6 style
  *	  arm7		- ARM7 style
  *	  v4_early	- ARMv4 without Thumb early abort handler
  *	  v4t_late	- ARMv4 with Thumb late abort handler
  *	  v4t_early	- ARMv4 with Thumb early abort handler
- *	  v5tej_early	- ARMv5 with Thumb and Java early abort handler
+ *	  v5t_early	- ARMv5 with Thumb early abort handler
+ *	  v5tj_early	- ARMv5 with Thumb and Java early abort handler
  *	  xscale	- ARMv5 with Thumb with Xscale extensions
  *	  v6_early	- ARMv6 generic early abort handler
  *	  v7_early	- ARMv7 generic early abort handler
@@ -39,19 +39,19 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ABRT_LV4T
+#ifdef CONFIG_CPU_ABRT_EV4
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
 # else
-#  define CPU_DABORT_HANDLER v4t_late_abort
+#  define CPU_DABORT_HANDLER v4_early_abort
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ABRT_EV4
+#ifdef CONFIG_CPU_ABRT_LV4T
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
 # else
-#  define CPU_DABORT_HANDLER v4_early_abort
+#  define CPU_DABORT_HANDLER v4t_late_abort
 # endif
 #endif
 
@@ -63,19 +63,19 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ABRT_EV5TJ
+#ifdef CONFIG_CPU_ABRT_EV5T
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
 # else
-#  define CPU_DABORT_HANDLER v5tj_early_abort
+#  define CPU_DABORT_HANDLER v5t_early_abort
 # endif
 #endif
 
-#ifdef CONFIG_CPU_ABRT_EV5T
+#ifdef CONFIG_CPU_ABRT_EV5TJ
 # ifdef CPU_DABORT_HANDLER
 #  define MULTI_DABORT 1
 # else
-#  define CPU_DABORT_HANDLER v5t_early_abort
+#  define CPU_DABORT_HANDLER v5tj_early_abort
 # endif
 #endif
 
-- 
1.7.10.4
