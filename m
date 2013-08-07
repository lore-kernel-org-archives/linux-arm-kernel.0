From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:13:58 +0900
Subject: [PATCH 04/05] ARM: shmobile: Expose shmobile_invalidate_start()
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
References: <20130807221321.22251.22774.sendpatchset@w520>
Message-ID: <20130807221358.22251.9535.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Expose shmobile_invalidate_start() in common.h for
mach-shmobile. This function will be used for boot of
secondary processors on future non-SCU SMP platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 1 file changed, 1 insertion(+)

--- 0005/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-08-07 13:43:24.000000000 +0900
@@ -14,6 +14,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
