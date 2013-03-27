From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 14:01:31 +0100
Subject: [PATCH v2 2/5] ARM: imx27, imx5: Add kconfig selects for cpufreq-cpu0
In-Reply-To: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364389294-1997-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some config options not selected by imx27 and imx5 that are
necessary to use the cpufreq-cpu0 driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..4144fdc 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -128,6 +128,8 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select COMMON_CLK
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
@@ -155,6 +157,7 @@ config SOC_IMX35
 config SOC_IMX5
 	bool
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select ARCH_MX5
 	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
-- 
1.8.1.5
