From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:36 +0900
Subject: [PATCH v2 02/11] ARM: EXYNOS: use exynos_init_uarts() instead of
 exynos4_init_uarts()
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since exynos4_init_uarts() can be used for EXYNOS5 SoCs,
this patch changes the name of function to exynos_init_uarts().

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 3c3e61b..37257b0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -52,7 +52,7 @@ static const char name_exynos4412[] = "EXYNOS4412";
 
 static void exynos4_map_io(void);
 static void exynos4_init_clocks(int xtal);
-static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+static void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
 static struct cpu_table cpu_ids[] __initdata = {
@@ -61,7 +61,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
+		.init_uarts	= exynos_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4210,
 	}, {
@@ -69,7 +69,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
+		.init_uarts	= exynos_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4212,
 	}, {
@@ -77,7 +77,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
+		.init_uarts	= exynos_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4412,
 	},
@@ -481,7 +481,7 @@ static int __init exynos_init(void)
 
 /* uart registration process */
 
-static void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+static void __init exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	struct s3c2410_uartcfg *tcfg = cfg;
 	u32 ucnt;
-- 
1.7.4.4
