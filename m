From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:40 +0530
Subject: [PATCH 15/50] pinctrl: mvebu: Use devm_pinctrl_register() for pinctrl
 registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-16-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and remove
need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Andrew Andrianov <andrew@ncrmnt.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 6 ------
 drivers/pinctrl/mvebu/pinctrl-armada-375.c | 6 ------
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 6 ------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c | 6 ------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 6 ------
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 5 +----
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 6 ------
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 9 +--------
 8 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 73dc1bc..9cc1cc3 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -417,18 +417,12 @@ static int armada_370_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int armada_370_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver armada_370_pinctrl_driver = {
 	.driver = {
 		.name = "armada-370-pinctrl",
 		.of_match_table = armada_370_pinctrl_of_match,
 	},
 	.probe = armada_370_pinctrl_probe,
-	.remove = armada_370_pinctrl_remove,
 };
 
 module_platform_driver(armada_370_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index 54e9fbd..0706514 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -435,18 +435,12 @@ static int armada_375_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int armada_375_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver armada_375_pinctrl_driver = {
 	.driver = {
 		.name = "armada-375-pinctrl",
 		.of_match_table = of_match_ptr(armada_375_pinctrl_of_match),
 	},
 	.probe = armada_375_pinctrl_probe,
-	.remove = armada_375_pinctrl_remove,
 };
 
 module_platform_driver(armada_375_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 6ec82c6..4e84c8e 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -446,18 +446,12 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int armada_38x_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver armada_38x_pinctrl_driver = {
 	.driver = {
 		.name = "armada-38x-pinctrl",
 		.of_match_table = of_match_ptr(armada_38x_pinctrl_of_match),
 	},
 	.probe = armada_38x_pinctrl_probe,
-	.remove = armada_38x_pinctrl_remove,
 };
 
 module_platform_driver(armada_38x_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index fcfe9b4..e288f8b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -428,18 +428,12 @@ static int armada_39x_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int armada_39x_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver armada_39x_pinctrl_driver = {
 	.driver = {
 		.name = "armada-39x-pinctrl",
 		.of_match_table = of_match_ptr(armada_39x_pinctrl_of_match),
 	},
 	.probe = armada_39x_pinctrl_probe,
-	.remove = armada_39x_pinctrl_remove,
 };
 
 module_platform_driver(armada_39x_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index bf70e09..e4ea71a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -502,18 +502,12 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int armada_xp_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver armada_xp_pinctrl_driver = {
 	.driver = {
 		.name = "armada-xp-pinctrl",
 		.of_match_table = armada_xp_pinctrl_of_match,
 	},
 	.probe = armada_xp_pinctrl_probe,
-	.remove = armada_xp_pinctrl_remove,
 	.suspend = armada_xp_pinctrl_suspend,
 	.resume = armada_xp_pinctrl_resume,
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 95bfd06..f93ae0d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -840,12 +840,9 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 
 static int dove_pinctrl_remove(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = mvebu_pinctrl_remove(pdev);
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
-	return ret;
+	return 0;
 }
 
 static struct platform_driver dove_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 0f07dc55..a78e9a4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -481,18 +481,12 @@ static int kirkwood_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int kirkwood_pinctrl_remove(struct platform_device *pdev)
-{
-	return mvebu_pinctrl_remove(pdev);
-}
-
 static struct platform_driver kirkwood_pinctrl_driver = {
 	.driver = {
 		.name = "kirkwood-pinctrl",
 		.of_match_table = kirkwood_pinctrl_of_match,
 	},
 	.probe = kirkwood_pinctrl_probe,
-	.remove = kirkwood_pinctrl_remove,
 };
 
 module_platform_driver(kirkwood_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 3ef798f..b6ec6db 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -711,7 +711,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pctl->pctldev = pinctrl_register(&pctl->desc, &pdev->dev, pctl);
+	pctl->pctldev = devm_pinctrl_register(&pdev->dev, &pctl->desc, pctl);
 	if (IS_ERR(pctl->pctldev)) {
 		dev_err(&pdev->dev, "unable to register pinctrl driver\n");
 		return PTR_ERR(pctl->pctldev);
@@ -725,10 +725,3 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 
 	return 0;
 }
-
-int mvebu_pinctrl_remove(struct platform_device *pdev)
-{
-	struct mvebu_pinctrl *pctl = platform_get_drvdata(pdev);
-	pinctrl_unregister(pctl->pctldev);
-	return 0;
-}
-- 
2.1.4
