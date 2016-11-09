From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  9 Nov 2016 08:44:10 -0800
Subject: [PATCH] i.MX: Kconfig: Drop errata 769419 for Vybrid
Message-ID: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, VF610 uses revision r3p2 of the L2C-310
block, same as i.MX6Q+, which does not require a software workaround for
ARM errata 769419.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 9155b63..936c59d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -557,7 +557,6 @@ config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
 	select PINCTRL_VF610
-	select PL310_ERRATA_769419 if CACHE_L2X0
 
 	help
 	  This enables support for Freescale Vybrid VF610 processor.
-- 
2.5.5
