From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 23:26:20 -0800
Subject: [PATCH] ARM: exynos: Fix warning due to missing 'inline' in stub
Message-ID: <1355642780-26929-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In file included from arch/arm/mach-exynos/clock-exynos5.c:29:0:
arch/arm/mach-exynos/common.h:28:12: warning: 'exynos_pm_late_initcall' defined but not used [-Wunused-function]

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---

I've added this to the fixes branch on arm-soc. I've also noticed that
every single non-EXYNOS5 board/config fails to build. Kukjin?

 arch/arm/mach-exynos/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index dac146d..04744f9 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -25,7 +25,7 @@ void exynos_init_late(void);
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 int exynos_pm_late_initcall(void);
 #else
-static int exynos_pm_late_initcall(void) { return 0; }
+static inline int exynos_pm_late_initcall(void) { return 0; }
 #endif
 
 #ifdef CONFIG_ARCH_EXYNOS4
-- 
1.7.10.1.488.g05fbf7a
