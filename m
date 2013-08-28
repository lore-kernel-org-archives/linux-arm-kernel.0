From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:42:02 +0900
Subject: [PATCH 2/5] ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
In-Reply-To: <cover.1377651075.git.horms+renesas@verge.net.au>
References: <cover.1377651075.git.horms+renesas@verge.net.au>
Message-ID: <49ccded47badece7b1551a8bae83c1e4a0170b9b.1377651075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use shmobile_smp_cpu_disable() on sh73a0 since it
allows CPU Hotplug of any CPU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 8b3b977..25ddffc 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -71,18 +71,11 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
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
-- 
1.8.3.2
