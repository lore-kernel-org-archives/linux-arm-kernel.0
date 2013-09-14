From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 14 Sep 2013 22:46:34 +0900
Subject: [PATCH 02/05] ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
References: <20130914134616.19258.27110.sendpatchset@w520>
Message-ID: <20130914134634.19258.88978.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    5 -----
 1 file changed, 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-09-14 19:28:29.000000000 +0900
@@ -46,11 +46,6 @@ void __init sh73a0_register_twd(void)
 static int sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned int lcpu = cpu_logical_map(cpu);
-	int ret;
-
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
 
 	if (((__raw_readl(PSTR) >> (4 * lcpu)) & 3) == 3)
 		__raw_writel(1 << lcpu, WUPCR);	/* wake up */
