From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 May 2017 17:39:03 +0200
Subject: [PATCH] ARM: at91: select CONFIG_ARM_CPU_SUSPEND
Message-ID: <20170524153921.1682756-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference to cpu_resume requires the corresponding
generic code to be enabled when CONFIG_PM is set:

arch/arm/mach-at91/pm.o: In function `sama5d2_pm_init':
pm.c:(.init.text+0x5e8): undefined reference to `cpu_resume'

Fixes: 24a0f5c539f9 ("ARM: at91: pm: Add sama5d2 backup mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841e924143f9..cbd959b73654 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_AT91
 	bool "Atmel SoCs"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
+	select ARM_CPU_SUSPEND if PM
 	select COMMON_CLK_AT91
 	select GPIOLIB
 	select PINCTRL
-- 
2.9.0
