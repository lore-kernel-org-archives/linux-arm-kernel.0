From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 20:50:43 +0200
Subject: [PATCH] pinctrl: sunxi: depend on RESET_CONTROLLER
Message-ID: <1400871043-16409-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 R_PIO driver depends on the reset framework in a mandatory way. Express
this by adding a depends on the reset framework in Kconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index da1e83035789..73e0a305ea13 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -26,6 +26,7 @@ config PINCTRL_SUN6I_A31
 
 config PINCTRL_SUN6I_A31_R
 	def_bool PINCTRL_SUNXI || MACH_SUN6I
+	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN7I_A20
-- 
1.9.3
