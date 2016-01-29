From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:28 +0100
Subject: [PATCH 4/9] ARM: pxa: don't select GPIO_SYSFS for MIOA701
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_SYSFS is a common kernel functionality, not something
that a board specific Kconfig should have to worry about.
In MIOA701, we get a warning about the select when CONFIG_SYSFS
is disabled:

warning: (MACH_MIOA701) selects GPIO_SYSFS which has unmet direct dependencies (GPIOLIB && SYSFS)

This just removes the select and instead enables the symbol in
the defconfig file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig | 1 +
 arch/arm/mach-pxa/Kconfig      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 0cb724b5c639..dc5517eaf09f 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -378,6 +378,7 @@ CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_GPIO_MAX7301=m
+CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY_DEBUG=y
 CONFIG_PDA_POWER=m
 CONFIG_BATTERY_SBS=m
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f09683687963..01066cff16e4 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -297,7 +297,6 @@ config MACH_MAGICIAN
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
-	select GPIO_SYSFS
 	select IWMMXT
 	select PXA27x
 	help
-- 
2.7.0
