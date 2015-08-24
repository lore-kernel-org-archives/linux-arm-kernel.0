From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:16 +0900
Subject: [PATCH 16/18] ARM: zx: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-17-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Also, add static to the structure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-zx/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
index a369398..0297f92 100644
--- a/arch/arm/mach-zx/platsmp.c
+++ b/arch/arm/mach-zx/platsmp.c
@@ -176,7 +176,7 @@ static void zx_secondary_init(unsigned int cpu)
 	scu_power_mode(scu_base, SCU_PM_NORMAL);
 }
 
-struct smp_operations zx_smp_ops __initdata = {
+static const struct smp_operations zx_smp_ops __initconst = {
 	.smp_prepare_cpus	= zx_smp_prepare_cpus,
 	.smp_secondary_init	= zx_secondary_init,
 	.smp_boot_secondary	= zx_boot_secondary,
-- 
1.9.1
