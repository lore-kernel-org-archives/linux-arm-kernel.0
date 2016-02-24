From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:56 +0530
Subject: [PATCH 31/50] pinctrl: uniphier: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-32-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and remove
need of .remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c       |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c   |  1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 12 +-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  2 --
 8 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
index a7056dc..4a0439c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
@@ -878,7 +878,6 @@ MODULE_DEVICE_TABLE(of, ph1_ld4_pinctrl_match);
 
 static struct platform_driver ph1_ld4_pinctrl_driver = {
 	.probe = ph1_ld4_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ph1_ld4_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
index 1824831..150d339 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
@@ -1266,7 +1266,6 @@ MODULE_DEVICE_TABLE(of, ph1_ld6b_pinctrl_match);
 
 static struct platform_driver ph1_ld6b_pinctrl_driver = {
 	.probe = ph1_ld6b_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ph1_ld6b_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
index ec8e92d..b1f09e6 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
@@ -1552,7 +1552,6 @@ MODULE_DEVICE_TABLE(of, ph1_pro4_pinctrl_match);
 
 static struct platform_driver ph1_pro4_pinctrl_driver = {
 	.probe = ph1_pro4_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ph1_pro4_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
index e3d648e..3087f76 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
@@ -1343,7 +1343,6 @@ MODULE_DEVICE_TABLE(of, ph1_pro5_pinctrl_match);
 
 static struct platform_driver ph1_pro5_pinctrl_driver = {
 	.probe = ph1_pro5_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ph1_pro5_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
index c3700a3..ceb7a98 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
@@ -786,7 +786,6 @@ MODULE_DEVICE_TABLE(of, ph1_sld8_pinctrl_match);
 
 static struct platform_driver ph1_sld8_pinctrl_driver = {
 	.probe = ph1_sld8_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ph1_sld8_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
index bc00d75..e868030 100644
--- a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
@@ -1261,7 +1261,6 @@ MODULE_DEVICE_TABLE(of, proxstream2_pinctrl_match);
 
 static struct platform_driver proxstream2_pinctrl_driver = {
 	.probe = proxstream2_pinctrl_probe,
-	.remove = uniphier_pinctrl_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = proxstream2_pinctrl_match,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 589872c..0176061 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -665,7 +665,7 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	desc->pmxops = &uniphier_pmxops;
 	desc->confops = &uniphier_confops;
 
-	priv->pctldev = pinctrl_register(desc, dev, priv);
+	priv->pctldev = devm_pinctrl_register(dev, desc, priv);
 	if (IS_ERR(priv->pctldev)) {
 		dev_err(dev, "failed to register UniPhier pinctrl driver\n");
 		return PTR_ERR(priv->pctldev);
@@ -676,13 +676,3 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uniphier_pinctrl_probe);
-
-int uniphier_pinctrl_remove(struct platform_device *pdev)
-{
-	struct uniphier_pinctrl_priv *priv = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(priv->pctldev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(uniphier_pinctrl_remove);
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index e1e98b8..a21154f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -212,6 +212,4 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 			   struct pinctrl_desc *desc,
 			   struct uniphier_pinctrl_socdata *socdata);
 
-int uniphier_pinctrl_remove(struct platform_device *pdev);
-
 #endif /* __PINCTRL_UNIPHIER_H__ */
-- 
2.1.4
