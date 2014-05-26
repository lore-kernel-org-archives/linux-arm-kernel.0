From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 12:15:07 +0200
Subject: [PATCH 3/4] ARM: imx53: instanciate cpufreq device
In-Reply-To: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1401099308-9658-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instanciate the platform device for the i.MX5 specific
cpufreq driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 65850908a4b4..ca90967c10b7 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -26,9 +26,12 @@
 
 static void __init imx53_dt_init(void)
 {
+	struct platform_device_info devinfo = { .name = "imx5-cpufreq", };
+
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_full(&devinfo);
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
-- 
2.0.0.rc2
