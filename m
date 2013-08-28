From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:42:04 +0900
Subject: [PATCH 4/5] ARM: shmobile: Expose shmobile_invalidate_start()
In-Reply-To: <cover.1377651075.git.horms+renesas@verge.net.au>
References: <cover.1377651075.git.horms+renesas@verge.net.au>
Message-ID: <eb2d656152e3e712c8798f7cc2dd99771c969920.1377651075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Expose shmobile_invalidate_start() in common.h for
mach-shmobile. This function will be used for boot of
secondary processors on future non-SCU SMP platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e64515e..1ffe39c 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -15,6 +15,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
-- 
1.8.3.2
