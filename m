From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:03 +0900
Subject: [PATCH 03/18] ARM: alpine: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-alpine/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-alpine/platsmp.c b/arch/arm/mach-alpine/platsmp.c
index f78429f..dd77ea2 100644
--- a/arch/arm/mach-alpine/platsmp.c
+++ b/arch/arm/mach-alpine/platsmp.c
@@ -42,7 +42,7 @@ static void __init alpine_smp_prepare_cpus(unsigned int max_cpus)
 	alpine_cpu_pm_init();
 }
 
-static struct smp_operations alpine_smp_ops __initdata = {
+static const struct smp_operations alpine_smp_ops __initconst = {
 	.smp_prepare_cpus	= alpine_smp_prepare_cpus,
 	.smp_boot_secondary	= alpine_boot_secondary,
 };
-- 
1.9.1
