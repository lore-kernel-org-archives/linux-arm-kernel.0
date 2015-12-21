From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Dec 2015 09:42:17 +0100
Subject: [PATCH] pinctrl: bcm/cygnys/iproc: fixup rebase issue
Message-ID: <1450687337-16424-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Somehow this variable name screwed up in some rebase, fixed it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Pramod Kumar <pramodku@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 525ea138d9ca..314591a4609b 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -637,7 +637,7 @@ static int iproc_gpio_register_pinconf(struct iproc_gpio *chip)
 	return 0;
 }
 
-static void iproc_gpio_unregister_pinconf(struct cygnus_gpio *chip)
+static void iproc_gpio_unregister_pinconf(struct iproc_gpio *chip)
 {
 	pinctrl_unregister(chip->pctl);
 }
-- 
2.4.3
