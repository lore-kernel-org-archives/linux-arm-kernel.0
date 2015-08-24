From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:06 +0900
Subject: [PATCH 06/18] ARM: berlin: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-berlin/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 34a3753..41a626b 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -91,7 +91,7 @@ unmap_scu:
 	iounmap(scu_base);
 }
 
-static struct smp_operations berlin_smp_ops __initdata = {
+static const struct smp_operations berlin_smp_ops __initconst = {
 	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
 	.smp_boot_secondary	= berlin_boot_secondary,
 };
-- 
1.9.1
