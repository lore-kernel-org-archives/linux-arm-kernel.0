From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:30:17 +0200
Subject: [PATCH] ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
Message-ID: <2964094.prhBouhISv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel without CONFIG_PM, we get a link
error from referencing mxs_pm_init in the machine
descriptor. This defines a macro to NULL for that case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>

diff --git a/arch/arm/mach-mxs/pm.h b/arch/arm/mach-mxs/pm.h
index f57e7cd..09d77b0 100644
--- a/arch/arm/mach-mxs/pm.h
+++ b/arch/arm/mach-mxs/pm.h
@@ -9,6 +9,10 @@
 #ifndef __ARCH_MXS_PM_H
 #define __ARCH_MXS_PM_H
 
+#ifdef CONFIG_PM
 void mxs_pm_init(void);
+#else
+#define mxs_pm_init NULL
+#endif
 
 #endif
