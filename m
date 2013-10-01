From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:49 +0900
Subject: [PATCH 10/14] ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <344c62f7a65f9124d5262e34dab66d581081a3a7.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 522de5e..f2ca923 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -34,12 +34,6 @@
 
 static int emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int ret;
-
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
-
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
 }
-- 
1.8.4
