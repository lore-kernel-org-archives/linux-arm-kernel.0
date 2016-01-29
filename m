From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:50:38 +0100
Subject: [PATCH 6/6] ARM: exynos: select THERMAL_OF
In-Reply-To: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
Message-ID: <1454079040-3567945-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot select a symbol that has disabled dependencies, so
we get a warning if we ever enable EXYNOS_THERMAL without
also turning on THERMAL_OF:

warning: (ARCH_EXYNOS) selects EXYNOS_THERMAL which has unmet direct dependencies (THERMAL && (ARCH_EXYNOS || COMPILE_TEST) && THERMAL_OF)

This adds another 'select' in the platform code to avoid that
case. Alternatively, we could decide to not select EXYNOS_THERMAL
here and instead make it a user option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 652a0bb11578..5189bcecad12 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,7 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select THERMAL
+	select THERMAL_OF
 	select MFD_SYSCON
 	select CLKSRC_EXYNOS_MCT
 	select POWER_RESET
-- 
2.7.0
