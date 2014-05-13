From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 May 2014 17:23:17 +0200
Subject: [PATCH] pinctrl: sunxi: Enable the pinctrl Kconfig options by default
Message-ID: <1399994597-15177-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the freshly introduced Kconfig options whenever their matching
architecture is enabled.

Since the Kconfig symbols for these machines are going through a different
tree, keep PINCTRL_SUNXI around for the moment to avoid breaking the defconfig.
It should be removed eventually.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 3940d098d6cb..2007327e0c48 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -6,27 +6,27 @@ config PINCTRL_SUNXI
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN4I
        select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A10S
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN5I
        select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A13
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN5I
        select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN6I
        select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31_R
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN6I
        select PINCTRL_SUNXI
 
 config PINCTRL_SUN7I_A20
-       bool
+       def_bool PINCTRL_SUNXI || MACH_SUN7I
        select PINCTRL_SUNXI
 
 endif
-- 
1.9.3
