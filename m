From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 17:53:27 +0100
Subject: [PATCH 2/2] ARM: imx: Disable imx-cpufreq when cpufreq-cpu0 used
In-Reply-To: <1362934407-29030-1-git-send-email-mpa@pengutronix.de>
References: <1362934407-29030-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362934407-29030-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufreq-cpu0 has DT support. So if imx27 or imx51 is booted with DT
support, it should not use the old imx-cpufreq driver. Instead the
operating-points should be defined in the appropriate DT files.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..1247fe5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2156,6 +2156,7 @@ source "drivers/cpufreq/Kconfig"
 config CPU_FREQ_IMX
 	tristate "CPUfreq driver for i.MX CPUs"
 	depends on ARCH_MXC && CPU_FREQ
+	depends on (!GENERIC_CPUFREQ_CPU0 || (!MACH_IMX51_DT && !MACH_IMX27_DT))
 	select CPU_FREQ_TABLE
 	help
 	  This enables the CPUfreq driver for i.MX CPUs.
-- 
1.8.1.5
