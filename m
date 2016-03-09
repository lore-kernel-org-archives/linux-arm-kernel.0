From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  9 Mar 2016 09:11:49 +0700
Subject: [PATCH] pinctrl: pxa2xx: export symbols
Message-ID: <1457489509-5680-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa2xxx fails some automated builds because of unexported
symbols.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index d90e205cf809..f553313bc2ef 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -426,6 +426,7 @@ int pxa2xx_pinctrl_init(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_init);
 
 int pxa2xx_pinctrl_exit(struct platform_device *pdev)
 {
@@ -434,3 +435,4 @@ int pxa2xx_pinctrl_exit(struct platform_device *pdev)
 	pinctrl_unregister(pctl->pctl_dev);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
-- 
2.4.3
