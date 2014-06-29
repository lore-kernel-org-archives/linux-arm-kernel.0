From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Jun 2014 15:58:19 +0200
Subject: [PATCH] pinctrl: sunxi: Remove PINCTRL_SUNXI
Message-ID: <1404050299-27895-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PINCTRL_SUNXI configuration was kept only to deal with the introduction of
per-machine symbols and the various pintrl drivers through different tree.

Now that it's not useful anymore, we can just remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig   |  1 -
 drivers/pinctrl/sunxi/Kconfig | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f776c5f1bb89..997854b15b5e 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,7 +4,6 @@ menuconfig ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
-	select PINCTRL_SUNXI
 	select SUN4I_TIMER
 
 if ARCH_SUNXI
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 73e0a305ea13..4cbf458579d5 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -1,36 +1,33 @@
 if ARCH_SUNXI
 
-config PINCTRL_SUNXI
-	bool
-
 config PINCTRL_SUNXI_COMMON
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
-	def_bool PINCTRL_SUNXI || MACH_SUN4I
+	def_bool MACH_SUN4I
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A10S
-	def_bool PINCTRL_SUNXI || MACH_SUN5I
+	def_bool MACH_SUN5I
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A13
-	def_bool PINCTRL_SUNXI || MACH_SUN5I
+	def_bool MACH_SUN5I
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31
-	def_bool PINCTRL_SUNXI || MACH_SUN6I
+	def_bool MACH_SUN6I
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31_R
-	def_bool PINCTRL_SUNXI || MACH_SUN6I
+	def_bool MACH_SUN6I
 	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN7I_A20
-	def_bool PINCTRL_SUNXI || MACH_SUN7I
+	def_bool MACH_SUN7I
 	select PINCTRL_SUNXI_COMMON
 
 endif
-- 
2.0.0
