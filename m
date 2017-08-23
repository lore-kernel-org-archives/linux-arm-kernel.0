From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 15:27:23 +0200
Subject: [PATCH] ARM: ux500: don't select CPUFREQ_DT
Message-ID: <20170823132733.619811-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new 'select CPUFREQ_DT' statement causes a warning in some
configurations:

warning: (ARCH_U8500) selects CPUFREQ_DT which has unmet direct dependencies (CPU_FREQ && HAVE_CLK && OF && (!CPU_THERMAL || THERMAL))

No other platform does this, so I think for consistency it's
best if we remove it again from ux500 and instead add the driver
to the defconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 2b56e4af5a27..4740ac393297 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_U8500
 	select ARM_GIC
 	select CACHE_L2X0
 	select CLKSRC_NOMADIK_MTU
-	select CPUFREQ_DT
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-- 
2.9.0
