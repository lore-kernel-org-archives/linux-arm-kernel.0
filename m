From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 18 Jun 2012 20:10:51 +0200
Subject: [PATCH] pinctrl: select the proper symbol
Message-ID: <1340043051-28746-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Kconfig entry for the COH901 pin controller depended on
PINMUX_U300 which is stale, use PINCTRL_U300 as it is called
these days.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c6e6ae0..4c05fe8 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -130,7 +130,7 @@ config PINCTRL_U300
 
 config PINCTRL_COH901
 	bool "ST-Ericsson U300 COH 901 335/571 GPIO"
-	depends on GPIOLIB && ARCH_U300 && PINMUX_U300
+	depends on GPIOLIB && ARCH_U300 && PINCTRL_U300
 	help
 	  Say yes here to support GPIO interface on ST-Ericsson U300.
 	  The names of the two IP block variants supported are
-- 
1.7.9.2
