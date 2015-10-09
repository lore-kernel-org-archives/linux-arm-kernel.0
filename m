From: b51503@freescale.com (Bai Ping)
Date: Fri, 9 Oct 2015 23:35:30 +0800
Subject: [PATCH] ARM: imx: add cpufreq device for imx6ul
Message-ID: <1444404930-15390-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq device for i.MX6UL. Using the common
cpufreq of i.MX6 SOC.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index be832b9..acaf705 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -78,6 +78,12 @@ static void __init imx6ul_init_irq(void)
 	imx6_pm_ccm_init("fsl,imx6ul-ccm");
 }
 
+static void __init imx6ul_init_late(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+}
+
 static const char *imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	NULL,
@@ -86,5 +92,6 @@ static const char *imx6ul_dt_compat[] __initconst = {
 DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
 	.init_irq	= imx6ul_init_irq,
 	.init_machine	= imx6ul_init_machine,
+	.init_late	= imx6ul_init_late,
 	.dt_compat	= imx6ul_dt_compat,
 MACHINE_END
-- 
1.9.1
