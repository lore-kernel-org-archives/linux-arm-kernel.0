From: marex@denx.de (Marek Vasut)
Date: Mon,  1 Jul 2013 13:36:30 +0200
Subject: [PATCH] ARM: mxs: Fix mxs_pm_init if CONFIG_PM undefined
Message-ID: <1372678590-8765-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the CONFIG_PM is not defined, the mxs_pm_init() from pm.c
is not compiled and therefore mxs_pm_init() is not available. Make
sure that the kernel builds even if CONFIG_PM is not defined.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/pm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-mxs/pm.h b/arch/arm/mach-mxs/pm.h
index f57e7cd..9f1dcf0 100644
--- a/arch/arm/mach-mxs/pm.h
+++ b/arch/arm/mach-mxs/pm.h
@@ -9,6 +9,10 @@
 #ifndef __ARCH_MXS_PM_H
 #define __ARCH_MXS_PM_H
 
+#ifdef CONFIG_PM
 void mxs_pm_init(void);
+#else
+static inline void mxs_pm_init(void) {}
+#endif
 
 #endif
-- 
1.7.10.4
