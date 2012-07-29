From: develkernel412222@gmail.com (Devendra Naga)
Date: Sun, 29 Jul 2012 13:56:38 +0545
Subject: [PATCH] pinctrl-sirf: remove devm_kfree at error path
Message-ID: <1343549498-2217-1-git-send-email-develkernel412222@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the pointers that are allocated with devm_kzalloc will be automatically freed,
at unload time.

Signed-off-by: Devendra Naga <develkernel412222@gmail.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 2aae8a8..7fca6ce 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1217,7 +1217,6 @@ out_no_rsc_remap:
 	iounmap(spmx->gpio_virtbase);
 out_no_gpio_remap:
 	platform_set_drvdata(pdev, NULL);
-	devm_kfree(&pdev->dev, spmx);
 	return ret;
 }
 
-- 
1.7.9.5
