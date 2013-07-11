From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 11 Jul 2013 11:26:22 -0300
Subject: [PATCH v2] ARM: imx: Kconfig: Select ARM1136 related errata
Message-ID: <1373552782-14196-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ARM_ERRATA_411920 and CONFIG_ARM_ERRATA_364296 should be selected for
ARM1136 SoCs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Select the errata via Kconfig

 arch/arm/mach-imx/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f7a5ad1..1d15d5c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -123,6 +123,8 @@ config SOC_IMX27
 
 config SOC_IMX31
 	bool
+	select ARM_ERRATA_364296
+	select ARM_ERRATA_411920
 	select COMMON_CLK
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
@@ -132,6 +134,8 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
+	select ARM_ERRATA_364296
+	select ARM_ERRATA_411920
 	select COMMON_CLK
 	select CPU_V6K
 	select HAVE_EPIT
-- 
1.8.1.2
