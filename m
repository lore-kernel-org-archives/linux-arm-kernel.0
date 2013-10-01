From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:50 +0900
Subject: [PATCH 11/14] ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <deb4928ea39c5eeef1c9f4562b5cee71f06a31ad.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 0f05e9f..627c1f0 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -87,10 +87,6 @@ static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	unsigned int lcpu = cpu_logical_map(cpu);
 	int ret;
 
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
-
 	if (lcpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[lcpu];
 
-- 
1.8.4
