From: olof@lixom.net (Olof Johansson)
Date: Tue,  5 Feb 2013 13:14:30 -0800
Subject: [PATCH] ARM: tegra: remove empty tegra_smp_init_cpus()
Message-ID: <1360098870-24818-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on two separate cleanup branches, it's now empty and can be removed.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---

(Already applied on arm-soc, just posting for posterity)

 arch/arm/mach-tegra/platsmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index f06fc51..2c6b3d5 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -176,10 +176,6 @@ done:
 	return status;
 }
 
-static void __init tegra_smp_init_cpus(void)
-{
-}
-
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* Always mark the boot CPU (CPU0) as initialized. */
@@ -190,7 +186,6 @@ static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct smp_operations tegra_smp_ops __initdata = {
-	.smp_init_cpus		= tegra_smp_init_cpus,
 	.smp_prepare_cpus	= tegra_smp_prepare_cpus,
 	.smp_secondary_init	= tegra_secondary_init,
 	.smp_boot_secondary	= tegra_boot_secondary,
-- 
1.8.1.192.gc4361b8
