From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 05 Jun 2013 14:38:30 +0200
Subject: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
Message-ID: <1460854.rT4b7LefMM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no reason why ARCH_NEEDS_CPU_IDLE_COUPLED needs to be
hidden inside of "if CPU_IDLE", since it is a silent option.
Moving it outside lets platforms select this symbol unconditionally,
which avoid a warning from the ARM omap2plus_defconfig build:

warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects
	ARCH_NEEDS_CPU_IDLE_COUPLED which has unmet direct
	dependencies (CPU_IDLE)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm at vger.kernel.org

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f4511e6..2caddb0 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,9 +29,6 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
-config ARCH_NEEDS_CPU_IDLE_COUPLED
-	def_bool n
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
@@ -39,3 +36,6 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 endif
+
+config ARCH_NEEDS_CPU_IDLE_COUPLED
+	def_bool n
