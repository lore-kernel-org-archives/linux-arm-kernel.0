From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:52 +0800
Subject: [PATCH 03/10] ARM: imx6q: select ARM and PL310 errata
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM core r2p10 and PL310 r3p2 are integrated on imx6q.  Select
corresponding errata.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4f73866..3ce2771 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -832,6 +832,11 @@ config SOC_IMX6Q
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
+	select ARM_ERRATA_743622
+	select ARM_ERRATA_751472
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_775420
 	select ARM_GIC
 	select COMMON_CLK
 	select CPU_V7
@@ -843,6 +848,9 @@ config SOC_IMX6Q
 	select MFD_SYSCON
 	select PINCTRL
 	select PINCTRL_IMX6Q
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
 	select PM_OPP if PM
 
 	help
-- 
1.7.9.5
