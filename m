From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 15 Nov 2015 10:39:52 +0900
Subject: [PATCH 1/2] ARM: hisi: do not export smp_operations structures
In-Reply-To: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1447551593-22246-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three structures are only defined and referenced in
mach-hisi/platsmp.c.

Drop the declarations from the header and add static qualifier
to the definitions.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-hisi/core.h    | 3 ---
 arch/arm/mach-hisi/platsmp.c | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index c7648ef..e883583 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -6,17 +6,14 @@
 extern void hi3xxx_set_cpu_jump(int cpu, void *jump_addr);
 extern int hi3xxx_get_cpu_jump(int cpu);
 extern void secondary_startup(void);
-extern struct smp_operations hi3xxx_smp_ops;
 
 extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
-extern struct smp_operations hix5hd2_smp_ops;
 extern void hix5hd2_set_cpu(int cpu, bool enable);
 extern void hix5hd2_cpu_die(unsigned int cpu);
 
-extern struct smp_operations hip01_smp_ops;
 extern void hip01_set_cpu(int cpu, bool enable);
 extern void hip01_cpu_die(unsigned int cpu);
 #endif
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 5174412..3c5237d 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -89,7 +89,7 @@ static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-struct smp_operations hi3xxx_smp_ops __initdata = {
+static struct smp_operations hi3xxx_smp_ops __initdata = {
 	.smp_prepare_cpus	= hi3xxx_smp_prepare_cpus,
 	.smp_boot_secondary	= hi3xxx_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -126,7 +126,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 
-struct smp_operations hix5hd2_smp_ops __initdata = {
+static struct smp_operations hix5hd2_smp_ops __initdata = {
 	.smp_prepare_cpus	= hisi_common_smp_prepare_cpus,
 	.smp_boot_secondary	= hix5hd2_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -176,7 +176,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-struct smp_operations hip01_smp_ops __initdata = {
+static struct smp_operations hip01_smp_ops __initdata = {
 	.smp_prepare_cpus       = hisi_common_smp_prepare_cpus,
 	.smp_boot_secondary     = hip01_boot_secondary,
 };
-- 
1.9.1
