From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 21 Nov 2015 20:35:31 -0500 (EST)
Subject: [PATCH] mach-imx/mach-imx6ul.c: proper constness with __initconst
Message-ID: <alpine.LFD.2.20.1511212024220.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the pointer array and the pointed data have to be const when using
__initconst to be correct.  This also fixes LTO builds that otherwise 
fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index acaf7056ef..a38b16b699 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -84,7 +84,7 @@ static void __init imx6ul_init_late(void)
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 }
 
-static const char *imx6ul_dt_compat[] __initconst = {
+static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	NULL,
 };
