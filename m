From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:07 +0900
Subject: [PATCH 07/18] ARM: EXYNOS: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-8-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-exynos/common.h  | 2 +-
 arch/arm/mach-exynos/platsmp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1534925..e349a03 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -149,7 +149,7 @@ static inline void exynos_pm_init(void) {}
 extern void exynos_cpu_resume(void);
 extern void exynos_cpu_resume_ns(void);
 
-extern struct smp_operations exynos_smp_ops;
+extern const struct smp_operations exynos_smp_ops;
 
 extern void exynos_cpu_power_down(int cpu);
 extern void exynos_cpu_power_up(int cpu);
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 98a2c0c..5bd9559 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -479,7 +479,7 @@ static void exynos_cpu_die(unsigned int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-struct smp_operations exynos_smp_ops __initdata = {
+const struct smp_operations exynos_smp_ops __initconst = {
 	.smp_init_cpus		= exynos_smp_init_cpus,
 	.smp_prepare_cpus	= exynos_smp_prepare_cpus,
 	.smp_secondary_init	= exynos_secondary_init,
-- 
1.9.1
