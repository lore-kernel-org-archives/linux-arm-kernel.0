From: marex@denx.de (Marek Vasut)
Date: Tue,  1 Oct 2013 06:13:50 +0200
Subject: ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
Message-ID: <1380600830-6204-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

When building a kernel without CONFIG_PM, we get a link
error from referencing mxs_pm_init in the machine
descriptor. This defines a macro to NULL for that case.

Upstream commit: 7a9caf59f60e55a8caf96f856713bd0ef0cc25a7

From: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org

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
