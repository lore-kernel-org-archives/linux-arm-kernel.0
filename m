From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:33:42 +0900
Subject: [PATCH] ARM: tango: use const and __initconst for smp_operations
Message-ID: <1453721622-15437-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This newly added code missed the global fixup by commit 75305275a721
("ARM: use const and __initconst for smp_operations").  So fix it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-tango/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index a18d5a3..a21f55e 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -9,7 +9,7 @@ static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-static struct smp_operations tango_smp_ops __initdata = {
+static const struct smp_operations tango_smp_ops __initconst = {
 	.smp_boot_secondary	= tango_boot_secondary,
 };
 
-- 
1.9.1
