From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue,  7 Jan 2014 17:44:04 -0800
Subject: [PATCH] ARM: imx: select ARCH_HAS_CPUFREQ for iMX6SL
Message-ID: <1389145444-61816-1-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iMX6SL now supported the cpufreq scaling by re-using the imx6q-cpufreq driver.
By adding it, the user has the capability to select the said driver without
depending it to SOC_IMX6Q.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7a6e6f7..704e5ae 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -808,6 +808,7 @@ config SOC_IMX6Q
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
+	select ARCH_HAS_CPUFREQ
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
-- 
1.8.3.2
