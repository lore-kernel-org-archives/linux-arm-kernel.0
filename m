From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:10 +0900
Subject: [PATCH 10/18] ARM: mvebu: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-11-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-mvebu/armada-370-xp.h | 2 +-
 arch/arm/mach-mvebu/platsmp-a9.c    | 4 ++--
 arch/arm/mach-mvebu/platsmp.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c55bbf8..09413b6 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_SMP
 void armada_xp_secondary_startup(void);
-extern struct smp_operations armada_xp_smp_ops;
+extern const struct smp_operations armada_xp_smp_ops;
 #endif
 
 #endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 3d50004..d715dec 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -93,11 +93,11 @@ static int armada_38x_cpu_kill(unsigned int cpu)
 }
 #endif
 
-static struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
+static const struct smp_operations mvebu_cortex_a9_smp_ops __initconst = {
 	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
 };
 
-static struct smp_operations armada_38x_smp_ops __initdata = {
+static const struct smp_operations armada_38x_smp_ops __initconst = {
 	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
 	.smp_secondary_init     = armada_38x_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 58cc8c1..f9597b7 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -170,7 +170,7 @@ static int armada_xp_cpu_kill(unsigned int cpu)
 }
 #endif
 
-struct smp_operations armada_xp_smp_ops __initdata = {
+const struct smp_operations armada_xp_smp_ops __initconst = {
 	.smp_init_cpus		= armada_xp_smp_init_cpus,
 	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
 	.smp_boot_secondary	= armada_xp_boot_secondary,
-- 
1.9.1
