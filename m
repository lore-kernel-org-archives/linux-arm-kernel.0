From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:18 +0900
Subject: [PATCH 18/18] ARM: mcpm: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-19-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Also, __initconst has been moved after mcpm_smp_ops because
scripts/checkpatch.pl suggests to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/common/mcpm_platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 92e54d7..1011b0e 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -87,7 +87,7 @@ static void mcpm_cpu_die(unsigned int cpu)
 
 #endif
 
-static struct smp_operations __initdata mcpm_smp_ops = {
+static const struct smp_operations mcpm_smp_ops __initconst = {
 	.smp_boot_secondary	= mcpm_boot_secondary,
 	.smp_secondary_init	= mcpm_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
