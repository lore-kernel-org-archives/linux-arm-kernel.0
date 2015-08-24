From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:15 +0900
Subject: [PATCH 15/18] ARM: uniphier: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-16-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index 4b784f7..da5359c 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -76,7 +76,7 @@ static int uniphier_boot_secondary(unsigned int cpu,
 	return ret;
 }
 
-struct smp_operations uniphier_smp_ops __initdata = {
+static const struct smp_operations uniphier_smp_ops __initconst = {
 	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
 	.smp_boot_secondary	= uniphier_boot_secondary,
 };
-- 
1.9.1
