From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:50 +0200
Subject: [PATCH 1/9] ARM: tegra: Tegra114 needs CPU_FREQ_TABLE
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like the other Tegra SoCs using the same cpufreq driver, we
have to enable CPU_FREQ_TABLE for this one.

drivers/built-in.o: In function `tegra_cpu_exit':
 drivers/cpufreq/tegra-cpufreq.c:237: undefined reference to
 `cpufreq_frequency_table_cpuinfo'

Cc: Stephen Warren <swarren@nvidia.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 597e76b..9878503 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -63,6 +63,7 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ARCH_TIMER
 	select ARM_GIC
 	select ARM_L1_CACHE_SHIFT_6
+	select CPU_FREQ_TABLE if CPU_FREQ
 	select CPU_V7
 	select PINCTRL
 	select PINCTRL_TEGRA114
-- 
1.8.1.2
