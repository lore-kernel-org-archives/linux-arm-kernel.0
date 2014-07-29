From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Jul 2014 15:32:24 +0800
Subject: [PATCH] ARM: imx: remove unnecessary ARCH_HAS_OPP select
Message-ID: <1406619144-20095-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARCH_MXC already selects ARCH_HAS_OPP, it's really unnecessary for
SOC_IMX27 and SOC_IMX5 to select it again.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2bc7b97861b4..aab4e7718791 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -86,7 +86,6 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
-	select ARCH_HAS_OPP
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -660,7 +659,6 @@ comment "Device tree only"
 
 config SOC_IMX5
 	bool
-	select ARCH_HAS_OPP
 	select HAVE_IMX_SRC
 	select MXC_TZIC
 
-- 
1.9.1
