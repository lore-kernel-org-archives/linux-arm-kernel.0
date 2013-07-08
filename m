From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Jul 2013 14:58:37 -0300
Subject: [PATCH 2/3] ARM: mx3: Select ARM_ERRATA_411920
In-Reply-To: <1373306318-15604-1-git-send-email-festevam@gmail.com>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
Message-ID: <1373306318-15604-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

ARM_ERRATA_411920 affects mx31 and mx35, so let's enable it:

ARM_ERRATA_411920:
	  Invalidation of the Instruction Cache operation can
	  fail. This erratum is present in 1136 (before r1p4), 1156 and 1176.
	  It does not affect the MPCore. This option enables the ARM Ltd.
	  recommended workaround.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f864af2..a0a89c4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -122,6 +122,7 @@ config SOC_IMX27
 
 config SOC_IMX31
 	bool
+	select ARM_ERRATA_411920
 	select CACHE_L2X0
 	select COMMON_CLK
 	select CPU_V6
@@ -132,6 +133,7 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
+	select ARM_ERRATA_411920
 	select CACHE_L2X0
 	select COMMON_CLK
 	select CPU_V6K
-- 
1.8.1.2
