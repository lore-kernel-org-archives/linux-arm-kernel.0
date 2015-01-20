From: stefan@agner.ch (Stefan Agner)
Date: Wed, 21 Jan 2015 00:12:45 +0100
Subject: [PATCH] ARM: vf610: use SMP_ON_UP for Vybrid SoC
Message-ID: <1421795565-3370-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Vybrid SoC has only one Cortex-A5 core and hence should select
the SMP_ON_UP configuration on a SMP kernel.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e8627e0..b8d3ccd 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -634,6 +634,7 @@ config SOC_VF610
 	select ARM_GIC
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SMP_ON_UP if SMP
 
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
-- 
2.2.2
