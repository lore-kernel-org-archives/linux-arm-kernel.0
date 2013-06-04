From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  4 Jun 2013 14:03:18 -0300
Subject: [PATCH] cpufreq: kirkwood: Select CPU_FREQ_TABLE option
Message-ID: <1370365398-484-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to select CPU_FREQ_TABLE in order to build without
this kind of errors:

drivers/built-in.o: In function `kirkwood_cpufreq_cpu_exit':
/home/zeta/linux-devel/marvell-legacy/drivers/cpufreq/kirkwood-cpufreq.c:145:
undefined reference to `cpufreq_frequency_table_put_attr'

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 6e57543..a2f0f08 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -86,6 +86,7 @@ config ARM_INTEGRATOR
 
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool ARCH_KIRKWOOD && OF
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
-- 
1.8.1.5
