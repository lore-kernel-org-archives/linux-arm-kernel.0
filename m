From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  1 Mar 2017 03:08:15 +0800
Subject: [PATCH] pinctrl: sunxi: select GPIOLIB
Message-ID: <20170228190815.10699-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner pin controllers are also GPIO controllers.

Currently, if GPIOLIB is forgot to be chosen, the build of
pinctrl-sunxi.c will fail for lacking a lot of gpiochip_* functions.

Select GPIOLIB to ensure this driver can be built.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
This bug is found when I try to add sunxi drivers on an ARM64
allnoconfig, in order to prove that sunxi-ng ccu driver depends on
reset_controller framework.

I proved the latter dependency, but how to satisfy it still needs
some discussion.

 drivers/pinctrl/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 816015cf7053..e25d0daa660a 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -4,6 +4,7 @@ config PINCTRL_SUNXI
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
+	select GPIOLIB
 
 config PINCTRL_SUN4I_A10
 	def_bool MACH_SUN4I
-- 
2.11.1
