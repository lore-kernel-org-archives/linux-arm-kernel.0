From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 25 Mar 2016 11:14:02 +0900
Subject: [PATCH] ARM: uniphier: drop weird sizeof()
Message-ID: <1458872042-30465-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My intention was to ioremap a 4-byte register.  Coincidentally enough,
sizeof(SZ_4) equals to SZ_4, but this code is weird anyway.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 6914135..db04142 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -120,7 +120,7 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 	if (ret)
 		return ret;
 
-	uniphier_smp_rom_boot_rsv2 = ioremap(rom_rsv2_phys, sizeof(SZ_4));
+	uniphier_smp_rom_boot_rsv2 = ioremap(rom_rsv2_phys, SZ_4);
 	if (!uniphier_smp_rom_boot_rsv2) {
 		pr_err("failed to map ROM_BOOT_RSV2 register\n");
 		return -ENOMEM;
-- 
1.9.1
