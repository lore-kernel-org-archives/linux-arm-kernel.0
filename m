From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Jun 2012 23:40:54 +0200
Subject: [PATCH] pinctrl/u300: drop unused variable
Message-ID: <1340142054-14077-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The "i" variable was left after the GPIO range cleanup
moved to core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-u300.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index 5f43f9a..a7ad8c1 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1173,7 +1173,6 @@ out_no_resource:
 static int __devexit u300_pmx_remove(struct platform_device *pdev)
 {
 	struct u300_pmx *upmx = platform_get_drvdata(pdev);
-	int i;
 
 	pinctrl_unregister(upmx->pctl);
 	iounmap(upmx->virtbase);
-- 
1.7.9.2
