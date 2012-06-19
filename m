From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Jun 2012 23:38:32 +0200
Subject: [PATCH] pinctrl/coh901: use clk_prepare_enable()
Message-ID: <1340141912-13111-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The COH901 GPIO driver did not prepare its clock, so let us
fix it to do so.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-coh901.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 55697a5..1b5d232a 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -770,7 +770,7 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 		dev_err(gpio->dev, "could not get GPIO clock\n");
 		goto err_no_clk;
 	}
-	err = clk_enable(gpio->clk);
+	err = clk_prepare_enable(gpio->clk);
 	if (err) {
 		dev_err(gpio->dev, "could not enable GPIO clock\n");
 		goto err_no_clk_enable;
-- 
1.7.9.2
