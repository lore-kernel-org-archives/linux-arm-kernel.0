From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Jul 2014 15:28:27 +0800
Subject: [PATCH] ARM: imx: drop PL310 errata 588369 and 727915
Message-ID: <1404286107-9553-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL310 integrated on i.MX6 series and VF610 are revision r3p1 and
later.  Per ARM PL310 errata document, 588369 is fixed in r2p0 and
727915 is fixed in r3p1.  Neither is needed for i.MX6 or VF610.  So
let's drop them.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ca187bea74ca..1350785e15a6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -722,8 +722,6 @@ config SOC_IMX6
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select MFD_SYSCON
-	select PL310_ERRATA_588369 if CACHE_PL310
-	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
 
 config SOC_IMX6Q
@@ -759,8 +757,6 @@ config SOC_VF610
 	select ARM_GIC
 	select PINCTRL_VF610
 	select VF_PIT_TIMER
-	select PL310_ERRATA_588369 if CACHE_PL310
-	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
 
 	help
-- 
1.8.3.2
