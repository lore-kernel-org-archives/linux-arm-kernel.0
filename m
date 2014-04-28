From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:41 -0700
Subject: [PATCH 15/15] ARM: sunxi: Update pinctrl Kconfig options
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-16-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on the global pinctrl option, select the matching pinctrl
driver per each SoC.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 23575010ff49..02fcede2e086 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,7 +4,6 @@ config ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
-	select PINCTRL_SUNXI
 	select SUN4I_TIMER
 
 if ARCH_SUNXI
@@ -13,15 +12,20 @@ menu "Allwinner SoCs variants"
 
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
+	select PINCTRL_SUN4I_A10
 
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
+	select PINCTRL_SUN5I_A10S
+	select PINCTRL_SUN5I_A13
 	select SUN5I_HSTIMER
 
 config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
+	select PINCTRL_SUN6I_A31
+	select PINCTRL_SUN6I_A31_R
 	select RESET_CONTROLLER
 	select SUN5I_HSTIMER
 
@@ -30,6 +34,7 @@ config MACH_SUN7I
 	select ARM_GIC
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+	select PINCTRL_SUN7I_A20
 	select SUN5I_HSTIMER
 
 endmenu
-- 
1.9.1
