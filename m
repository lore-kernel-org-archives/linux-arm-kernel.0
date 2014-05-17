From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 May 2014 18:21:55 +0200
Subject: [PATCH] pinctrl: sunxi: Fix recursive dependency
Message-ID: <1400343715-27884-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following configuration error:
drivers/pinctrl/sunxi/Kconfig:3:error: recursive dependency detected!
drivers/pinctrl/sunxi/Kconfig:3:	symbol PINCTRL_SUNXI is selected by PINCTRL_SUN4I_A10
drivers/pinctrl/sunxi/Kconfig:9:	symbol PINCTRL_SUN4I_A10 default value contains PINCTRL_SUNXI

Drop the select on PINCTRL_SUNXI, and make PINCTRL_SUNXI enabled by default instead.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 2007327e0c48..8411857d2a45 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -1,32 +1,26 @@
 if ARCH_SUNXI
 
 config PINCTRL_SUNXI
-	bool
+	def_bool ARCH_SUNXI
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
        def_bool PINCTRL_SUNXI || MACH_SUN4I
-       select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A10S
        def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A13
        def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31
        def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31_R
        def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
 
 config PINCTRL_SUN7I_A20
        def_bool PINCTRL_SUNXI || MACH_SUN7I
-       select PINCTRL_SUNXI
 
 endif
-- 
1.9.3
