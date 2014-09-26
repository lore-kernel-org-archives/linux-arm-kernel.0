From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 26 Sep 2014 15:41:04 +0200
Subject: [PATCH v2 6/6] ARM: imx53: add cpufreq support
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instanciate device for the generic cpufreq-dt driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- new patch, split out from DTS changes and rebased
  with new name for cpufreq driver
---
 arch/arm/mach-imx/mach-imx53.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 03dd6ea13acc..7587cf0cba3e 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -41,6 +41,8 @@ static void __init imx53_dt_init(void)
 static void __init imx53_init_late(void)
 {
 	imx53_pm_init();
+
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 }
 
 static const char * const imx53_dt_board_compat[] __initconst = {
-- 
2.1.0
