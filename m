From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:16 +0200
Subject: [PATCH 05/15] ARM: shmobile: Remove unused
 shmobile_smp_init_fallback_ops()
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <aa03319f28402fa7613d313b411490952b3f9bd4.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

shmobile_smp_init_fallback_ops() became unused after removing
SoC-specific machine definitions that provided legacy SMP initialization
fallbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h  | 1 -
 arch/arm/mach-shmobile/platsmp.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 2109f123bdfb..3ac4b36b5c2b 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -15,7 +15,6 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
-extern bool shmobile_smp_init_fallback_ops(void);
 extern void shmobile_boot_apmu(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 02e21bceb085..b23378f3d7e1 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -36,12 +36,3 @@ bool shmobile_smp_cpu_can_disable(unsigned int cpu)
 	return true; /* Hotplug of any CPU is supported */
 }
 #endif
-
-bool __init shmobile_smp_init_fallback_ops(void)
-{
-	/* fallback on PSCI/smp_ops if no other DT based method is detected */
-	if (!IS_ENABLED(CONFIG_SMP))
-		return false;
-
-	return platform_can_secondary_boot() ? true : false;
-}
-- 
2.11.0
