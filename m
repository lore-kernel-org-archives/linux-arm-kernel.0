From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue,  7 Jan 2014 19:17:29 -0800
Subject: [PATCH] ARM: imx: select PM_OPP for iMX6SL
Message-ID: <1389151049-13451-1-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM_OPP is required if the user wants to use the imx6q-cpufreq driver.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 704e5ae..5e73596 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -823,6 +823,7 @@ config SOC_IMX6SL
 	select PL310_ERRATA_588369 if CACHE_PL310
 	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
+	select PM_OPP if PM
 
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
-- 
1.8.3.2
