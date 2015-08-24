From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:05 +0900
Subject: [PATCH 05/18] ARM: BCM: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Also, add static to bcm63138_smp_ops.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-bcm/bcm63xx_smp.c     | 2 +-
 arch/arm/mach-bcm/kona_smp.c        | 2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index 19be904..9b6727e 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -161,7 +161,7 @@ static void __init bcm63138_smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-struct smp_operations bcm63138_smp_ops __initdata = {
+static const struct smp_operations bcm63138_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm63138_smp_prepare_cpus,
 	.smp_boot_secondary	= bcm63138_smp_boot_secondary,
 };
diff --git a/arch/arm/mach-bcm/kona_smp.c b/arch/arm/mach-bcm/kona_smp.c
index 66a0465..da8328b 100644
--- a/arch/arm/mach-bcm/kona_smp.c
+++ b/arch/arm/mach-bcm/kona_smp.c
@@ -194,7 +194,7 @@ static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return -ENOSYS;
 }
 
-static struct smp_operations bcm_smp_ops __initdata = {
+static const struct smp_operations bcm_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
 	.smp_boot_secondary	= bcm_boot_secondary,
 };
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 44d6bddf..40dc844 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -356,7 +356,7 @@ static int brcmstb_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-static struct smp_operations brcmstb_smp_ops __initdata = {
+static const struct smp_operations brcmstb_smp_ops __initconst = {
 	.smp_prepare_cpus	= brcmstb_cpu_ctrl_setup,
 	.smp_boot_secondary	= brcmstb_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
