From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:13:39 +0900
Subject: [PATCH 02/05] ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
References: <20130807221321.22251.22774.sendpatchset@w520>
Message-ID: <20130807221339.22251.99940.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use shmobile_smp_cpu_disable() on sh73a0 since it
allows CPU Hotplug of any CPU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- 0008/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-07-29 22:21:29.000000000 +0900
@@ -71,18 +71,11 @@ static void __init sh73a0_smp_prepare_cp
 	shmobile_smp_scu_prepare_cpus(max_cpus);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-static int sh73a0_cpu_disable(unsigned int cpu)
-{
-	return 0; /* CPU0 and CPU1 supported */
-}
-#endif /* CONFIG_HOTPLUG_CPU */
-
 struct smp_operations sh73a0_smp_ops __initdata = {
 	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
 	.smp_boot_secondary	= sh73a0_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= sh73a0_cpu_disable,
+	.cpu_disable		= shmobile_smp_cpu_disable,
 	.cpu_die		= shmobile_smp_scu_cpu_die,
 	.cpu_kill		= shmobile_smp_scu_cpu_kill,
 #endif
