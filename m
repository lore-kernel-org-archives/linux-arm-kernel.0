From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:33 +0530
Subject: [PATCH 08/50] pinctrl: berlin: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-9-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 46f2b48..2d58166 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -316,7 +316,8 @@ int berlin_pinctrl_probe_regmap(struct platform_device *pdev,
 		return ret;
 	}
 
-	pctrl->pctrl_dev = pinctrl_register(&berlin_pctrl_desc, dev, pctrl);
+	pctrl->pctrl_dev = devm_pinctrl_register(dev, &berlin_pctrl_desc,
+						 pctrl);
 	if (IS_ERR(pctrl->pctrl_dev)) {
 		dev_err(dev, "failed to register pinctrl driver\n");
 		return PTR_ERR(pctrl->pctrl_dev);
-- 
2.1.4
