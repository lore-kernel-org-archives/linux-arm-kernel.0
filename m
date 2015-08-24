From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:09 +0900
Subject: [PATCH 09/18] ARM: hisi: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-10-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-hisi/platsmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 3c5237d..47ed32c 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -89,7 +89,7 @@ static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-static struct smp_operations hi3xxx_smp_ops __initdata = {
+static const struct smp_operations hi3xxx_smp_ops __initconst = {
 	.smp_prepare_cpus	= hi3xxx_smp_prepare_cpus,
 	.smp_boot_secondary	= hi3xxx_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -126,7 +126,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 
-static struct smp_operations hix5hd2_smp_ops __initdata = {
+static const struct smp_operations hix5hd2_smp_ops __initconst = {
 	.smp_prepare_cpus	= hisi_common_smp_prepare_cpus,
 	.smp_boot_secondary	= hix5hd2_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -176,7 +176,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-static struct smp_operations hip01_smp_ops __initdata = {
+static const struct smp_operations hip01_smp_ops __initconst = {
 	.smp_prepare_cpus       = hisi_common_smp_prepare_cpus,
 	.smp_boot_secondary     = hip01_boot_secondary,
 };
-- 
1.9.1
