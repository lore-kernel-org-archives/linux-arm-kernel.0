From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:34:33 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: exynos4-dt: Use exynos4 prefix instead of
 exynos4210
In-Reply-To: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
References: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346675674-16034-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since mach-exynos4-dt.c is also going to be used for other SoCs from Exynos4
line, rename internal structures and functions to use exynos4_ prefix, instead
of exynos4210_.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos4-dt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index b2b5d5f..8dad4ec 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -1,5 +1,5 @@
 /*
- * Samsung's Exynos4210 flattened device tree enabled machine
+ * Samsung's Exynos4 flattened device tree enabled machine
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -36,7 +36,7 @@
  * at some point, the drivers should be capable of parsing all the platform
  * data from the device tree.
  */
-static const struct of_dev_auxdata exynos4210_auxdata_lookup[] __initconst = {
+static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART0,
 				"exynos4210-uart.0", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS4_PA_UART1,
@@ -66,19 +66,19 @@ static const struct of_dev_auxdata exynos4210_auxdata_lookup[] __initconst = {
 	{},
 };
 
-static void __init exynos4210_dt_map_io(void)
+static void __init exynos4_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 }
 
-static void __init exynos4210_dt_machine_init(void)
+static void __init exynos4_dt_machine_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
-				exynos4210_auxdata_lookup, NULL);
+				exynos4_auxdata_lookup, NULL);
 }
 
-static char const *exynos4210_dt_compat[] __initdata = {
+static char const *exynos4_dt_compat[] __initdata = {
 	"samsung,exynos4210",
 	NULL
 };
@@ -86,11 +86,11 @@ static char const *exynos4210_dt_compat[] __initdata = {
 DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
 	.init_irq	= exynos4_init_irq,
-	.map_io		= exynos4210_dt_map_io,
+	.map_io		= exynos4_dt_map_io,
 	.handle_irq	= gic_handle_irq,
-	.init_machine	= exynos4210_dt_machine_init,
+	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
-	.dt_compat	= exynos4210_dt_compat,
+	.dt_compat	= exynos4_dt_compat,
 	.restart        = exynos4_restart,
 MACHINE_END
-- 
1.7.12
