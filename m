From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:13 +0900
Subject: [PATCH 13/18] ARM: socfpga: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-14-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-socfpga/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 15c8ce8..cbb0a54 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -117,7 +117,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
 	return 1;
 }
 
-static struct smp_operations socfpga_smp_ops __initdata = {
+static const struct smp_operations socfpga_smp_ops __initconst = {
 	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
 	.smp_boot_secondary	= socfpga_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -126,7 +126,7 @@ static struct smp_operations socfpga_smp_ops __initdata = {
 #endif
 };
 
-static struct smp_operations socfpga_a10_smp_ops __initdata = {
+static const struct smp_operations socfpga_a10_smp_ops __initconst = {
 	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
 	.smp_boot_secondary	= socfpga_a10_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
