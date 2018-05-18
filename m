From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 May 2018 14:48:54 +0200
Subject: [PATCH 5/5] ARM: shmobile: Remove unused
 shmobile_smp_init_fallback_ops()
In-Reply-To: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
References: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1526647734-1200-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shmobile_smp_init_fallback_ops() became unused after removing
SoC-specific machine definitions that provided legacy SMP initialization
fallbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/common.h  | 1 -
 arch/arm/mach-shmobile/platsmp.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 43c1ac6962741757..5d2b1473e11eb612 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -16,7 +16,6 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
-extern bool shmobile_smp_init_fallback_ops(void);
 extern void shmobile_boot_apmu(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 02e21bceb0856bc5..b23378f3d7e1726b 100644
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
2.7.4
