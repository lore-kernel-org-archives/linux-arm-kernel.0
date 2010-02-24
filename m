From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 24 Feb 2010 11:31:31 +0200
Subject: [PATCH] mx25: move ARCH_MXC_IOMUX_V3 to the ARCH level
Message-ID: <3152e0f2d1d239c4363b1c624cb2fe208edb99e3.1267003785.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_MXC_IOMUX_V3 is not specific to the i.MX25 PDK platform. Thus,
ARCH_MXC_IOMUX_V3 should be selected by ARCH_MX25.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/Kconfig |    1 -
 arch/arm/plat-mxc/Kconfig  |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index cc28f56..54d2173 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -3,7 +3,6 @@ if ARCH_MX25
 comment "MX25 platforms:"
 
 config MACH_MX25_3DS
-	select ARCH_MXC_IOMUX_V3
 	bool "Support MX25PDK (3DS) Platform"
 
 endif
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 2a049df..31a1f40 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -24,6 +24,7 @@ config ARCH_MX25
 	bool "MX25-based"
 	select CPU_ARM926T
 	select COMMON_CLKDEV
+	select ARCH_MXC_IOMUX_V3
 	select HAVE_FB_IMX
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
-- 
1.6.6.1
