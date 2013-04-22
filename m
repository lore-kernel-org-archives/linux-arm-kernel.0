From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:51:53 +0200
Subject: [PATCH 04/23] pinctrl: u300 device tree support
Message-ID: <1366624313-6225-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds a simple device tree compat string for the U300 pin
controller. The base address is already passed properly as
a resource and everything works fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-u300.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index 2b57725..ae0a460 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1105,10 +1105,17 @@ static int u300_pmx_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id u300_pinctrl_match[] = {
+	{ .compatible = "stericsson,pinctrl-u300" },
+	{},
+};
+
+
 static struct platform_driver u300_pmx_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = u300_pinctrl_match,
 	},
 	.probe = u300_pmx_probe,
 	.remove = u300_pmx_remove,
-- 
1.7.11.3
