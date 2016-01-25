From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:31:15 +0900
Subject: [PATCH] ARM: bcm: use const and __initconst for smp_operations
Message-ID: <1453721475-15156-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This newly added code missed the global fixup by commit 75305275a721
("ARM: use const and __initconst for smp_operations").  So fix it now.

Also, add missing "static" qualifier.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-bcm/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 575defc..cfae9c7 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -283,7 +283,7 @@ static const struct smp_operations bcm_smp_ops __initconst = {
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm281xx, "brcm,bcm11351-cpu-method",
 			&bcm_smp_ops);
 
-struct smp_operations nsp_smp_ops __initdata = {
+static const struct smp_operations nsp_smp_ops __initconst = {
 	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
 	.smp_boot_secondary	= nsp_boot_secondary,
 };
-- 
1.9.1
