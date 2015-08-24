From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:14 +0900
Subject: [PATCH 14/18] ARM: sunxi: use const and __initconst for smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-15-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Also, add static to sun8i_smp_ops.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-sunxi/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index e8483ec..6642267 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -116,7 +116,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
-static struct smp_operations sun6i_smp_ops __initdata = {
+static const struct smp_operations sun6i_smp_ops __initconst = {
 	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun6i_smp_boot_secondary,
 };
@@ -185,7 +185,7 @@ static int sun8i_smp_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
-struct smp_operations sun8i_smp_ops __initdata = {
+static const struct smp_operations sun8i_smp_ops __initconst = {
 	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun8i_smp_boot_secondary,
 };
-- 
1.9.1
