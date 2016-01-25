From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:33:07 +0900
Subject: [PATCH] ARM: realview: use const and __initconst for smp_operations
Message-ID: <1453721587-15363-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This newly added code missed the global fixup by commit 75305275a721
("ARM: use const and __initconst for smp_operations").  So fix it now.

Also, add missing "static" qualifier.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-realview/platsmp-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index 6558539..6964e88 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -80,7 +80,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		     virt_to_phys(versatile_secondary_startup));
 }
 
-struct smp_operations realview_dt_smp_ops __initdata = {
+static const struct smp_operations realview_dt_smp_ops __initconst = {
 	.smp_prepare_cpus	= realview_smp_prepare_cpus,
 	.smp_secondary_init	= versatile_secondary_init,
 	.smp_boot_secondary	= versatile_boot_secondary,
-- 
1.9.1
