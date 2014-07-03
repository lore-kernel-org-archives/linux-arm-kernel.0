From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Jul 2014 22:55:47 +0800
Subject: [PATCH v3 7/9] ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch
 support is enabled
In-Reply-To: <1404399349-20237-1-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Message-ID: <1404399349-20237-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the MFD_SUN6I_PRCM option when sun8i arch is enabled in order to
get the PRCM (Power/Reset/Clock Management) related drivers compiled.

Also select ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER to make sure
the reset controller drivers are compiled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f776c5f..6434e3b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -38,6 +38,9 @@ config MACH_SUN7I
 config MACH_SUN8I
 	bool "Allwinner A23 (sun8i) SoCs support"
 	default ARCH_SUNXI
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
+	select MFD_SUN6I_PRCM
+	select RESET_CONTROLLER
 
 endif
-- 
2.0.1
