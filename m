From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jan 2014 23:45:12 +0100
Subject: [PATCH] pinctrl: capri: add dependency on OF
Message-ID: <1389912312-16285-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this driver is using pinconf_generic_dt_node_to_map_pin() it
needs to depend on OF so as not to cause build problems on
archs that do not support OF.

Cc: Sherman Yin <syin@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f1dda4d9de13..be361b7cd30f 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -106,6 +106,7 @@ config PINCTRL_BCM2835
 
 config PINCTRL_CAPRI
 	bool "Broadcom Capri pinctrl driver"
+	depends on OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
1.8.4.2
