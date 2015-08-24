From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:04 +0900
Subject: [PATCH 04/18] ARM: axxia: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-axxia/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index 959d4df..ffbd71d 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -82,7 +82,7 @@ static void __init axxia_smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static struct smp_operations axxia_smp_ops __initdata = {
+static const struct smp_operations axxia_smp_ops __initconst = {
 	.smp_prepare_cpus	= axxia_smp_prepare_cpus,
 	.smp_boot_secondary	= axxia_boot_secondary,
 };
-- 
1.9.1
