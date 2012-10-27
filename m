From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 27 Oct 2012 19:53:11 +0200
Subject: [PATCH 1/2] pinctrl/: at91: fix warmings
Message-ID: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c: In function 'at91_pinctrl_probe_dt':
/opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c:952:12: warning: assignment discards qualifiers from pointer target type
/opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c: In function 'at91_gpio_probe':
/opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c:1517:17: warning: assignment discards qualifiers from pointer target type

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/pinctrl/pinctrl-at91.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 0679643..6485d7e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -949,7 +949,7 @@ static int __devinit at91_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENODEV;
 
 	info->dev = &pdev->dev;
-	info->ops =
+	info->ops = (struct at91_pinctrl_mux_ops*)
 		of_match_device(at91_pinctrl_of_match, &pdev->dev)->data;
 	at91_pinctrl_child_count(info, np);
 
@@ -1514,7 +1514,7 @@ static int __devinit at91_gpio_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	at91_chip->ops =
+	at91_chip->ops = (struct at91_pinctrl_mux_ops*)
 		of_match_device(at91_gpio_of_match, &pdev->dev)->data;
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
-- 
1.7.10.4
