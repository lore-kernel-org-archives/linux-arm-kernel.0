From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:27 -0500
Subject: [PATCH 138/493] pinctrl: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com> 
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: spear-devel at list.st.com 
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 2 +-
 drivers/pinctrl/pinctrl-at91.c             | 2 +-
 drivers/pinctrl/pinctrl-imx23.c            | 2 +-
 drivers/pinctrl/pinctrl-imx28.c            | 2 +-
 drivers/pinctrl/pinctrl-imx35.c            | 2 +-
 drivers/pinctrl/pinctrl-imx51.c            | 2 +-
 drivers/pinctrl/pinctrl-imx53.c            | 2 +-
 drivers/pinctrl/pinctrl-imx6q.c            | 2 +-
 drivers/pinctrl/pinctrl-mmp2.c             | 2 +-
 drivers/pinctrl/pinctrl-pxa168.c           | 2 +-
 drivers/pinctrl/pinctrl-pxa910.c           | 2 +-
 drivers/pinctrl/pinctrl-single.c           | 2 +-
 drivers/pinctrl/pinctrl-tegra20.c          | 2 +-
 drivers/pinctrl/pinctrl-tegra30.c          | 2 +-
 drivers/pinctrl/pinctrl-u300.c             | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c   | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index c907647..95cd5b1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -411,7 +411,7 @@ static struct platform_driver armada_370_pinctrl_driver = {
 		.of_match_table = of_match_ptr(armada_370_pinctrl_of_match),
 	},
 	.probe = armada_370_pinctrl_probe,
-	.remove = __devexit_p(armada_370_pinctrl_remove),
+	.remove = armada_370_pinctrl_remove,
 };
 
 module_platform_driver(armada_370_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 40bd52a..cfecf0c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -458,7 +458,7 @@ static struct platform_driver armada_xp_pinctrl_driver = {
 		.of_match_table = of_match_ptr(armada_xp_pinctrl_of_match),
 	},
 	.probe = armada_xp_pinctrl_probe,
-	.remove = __devexit_p(armada_xp_pinctrl_remove),
+	.remove = armada_xp_pinctrl_remove,
 };
 
 module_platform_driver(armada_xp_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index ffe74b2..10d4472 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -610,7 +610,7 @@ static struct platform_driver dove_pinctrl_driver = {
 		.of_match_table = of_match_ptr(dove_pinctrl_of_match),
 	},
 	.probe = dove_pinctrl_probe,
-	.remove = __devexit_p(dove_pinctrl_remove),
+	.remove = dove_pinctrl_remove,
 };
 
 module_platform_driver(dove_pinctrl_driver);
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 9a74ef6..506ca41 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -462,7 +462,7 @@ static struct platform_driver kirkwood_pinctrl_driver = {
 		.of_match_table = of_match_ptr(kirkwood_pinctrl_of_match),
 	},
 	.probe = kirkwood_pinctrl_probe,
-	.remove = __devexit_p(kirkwood_pinctrl_remove),
+	.remove = kirkwood_pinctrl_remove,
 };
 
 module_platform_driver(kirkwood_pinctrl_driver);
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 8490a55..c58aaac 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1485,7 +1485,7 @@ static struct platform_driver at91_pinctrl_driver = {
 		.of_match_table = of_match_ptr(at91_pinctrl_of_match),
 	},
 	.probe = at91_pinctrl_probe,
-	.remove = __devexit_p(at91_pinctrl_remove),
+	.remove = at91_pinctrl_remove,
 };
 
 static int __init at91_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index 3674d87..67e1b3b 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -285,7 +285,7 @@ static struct platform_driver imx23_pinctrl_driver = {
 		.of_match_table = imx23_pinctrl_of_match,
 	},
 	.probe = imx23_pinctrl_probe,
-	.remove = __devexit_p(mxs_pinctrl_remove),
+	.remove = mxs_pinctrl_remove,
 };
 
 static int __init imx23_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index 0f5b212..feeb4b9 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -401,7 +401,7 @@ static struct platform_driver imx28_pinctrl_driver = {
 		.of_match_table = imx28_pinctrl_of_match,
 	},
 	.probe = imx28_pinctrl_probe,
-	.remove = __devexit_p(mxs_pinctrl_remove),
+	.remove = mxs_pinctrl_remove,
 };
 
 static int __init imx28_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx35.c b/drivers/pinctrl/pinctrl-imx35.c
index 82f109e..a88d087 100644
--- a/drivers/pinctrl/pinctrl-imx35.c
+++ b/drivers/pinctrl/pinctrl-imx35.c
@@ -1576,7 +1576,7 @@ static struct platform_driver imx35_pinctrl_driver = {
 		.of_match_table = of_match_ptr(imx35_pinctrl_of_match),
 	},
 	.probe = imx35_pinctrl_probe,
-	.remove = __devexit_p(imx_pinctrl_remove),
+	.remove = imx_pinctrl_remove,
 };
 
 static int __init imx35_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
index fb84689..5c48948 100644
--- a/drivers/pinctrl/pinctrl-imx51.c
+++ b/drivers/pinctrl/pinctrl-imx51.c
@@ -1303,7 +1303,7 @@ static struct platform_driver imx51_pinctrl_driver = {
 		.of_match_table = of_match_ptr(imx51_pinctrl_of_match),
 	},
 	.probe = imx51_pinctrl_probe,
-	.remove = __devexit_p(imx_pinctrl_remove),
+	.remove = imx_pinctrl_remove,
 };
 
 static int __init imx51_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
index 783feb1..8e5c15f 100644
--- a/drivers/pinctrl/pinctrl-imx53.c
+++ b/drivers/pinctrl/pinctrl-imx53.c
@@ -1630,7 +1630,7 @@ static struct platform_driver imx53_pinctrl_driver = {
 		.of_match_table = of_match_ptr(imx53_pinctrl_of_match),
 	},
 	.probe = imx53_pinctrl_probe,
-	.remove = __devexit_p(imx_pinctrl_remove),
+	.remove = imx_pinctrl_remove,
 };
 
 static int __init imx53_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index e9bf71f..831dae6 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -2314,7 +2314,7 @@ static struct platform_driver imx6q_pinctrl_driver = {
 		.of_match_table = of_match_ptr(imx6q_pinctrl_of_match),
 	},
 	.probe = imx6q_pinctrl_probe,
-	.remove = __devexit_p(imx_pinctrl_remove),
+	.remove = imx_pinctrl_remove,
 };
 
 static int __init imx6q_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-mmp2.c b/drivers/pinctrl/pinctrl-mmp2.c
index 2cfed55..a5159a3 100644
--- a/drivers/pinctrl/pinctrl-mmp2.c
+++ b/drivers/pinctrl/pinctrl-mmp2.c
@@ -702,7 +702,7 @@ static struct platform_driver mmp2_pinmux_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= mmp2_pinmux_probe,
-	.remove	= __devexit_p(mmp2_pinmux_remove),
+	.remove	= mmp2_pinmux_remove,
 };
 
 static int __init mmp2_pinmux_init(void)
diff --git a/drivers/pinctrl/pinctrl-pxa168.c b/drivers/pinctrl/pinctrl-pxa168.c
index c1997fa..4abab78 100644
--- a/drivers/pinctrl/pinctrl-pxa168.c
+++ b/drivers/pinctrl/pinctrl-pxa168.c
@@ -631,7 +631,7 @@ static struct platform_driver pxa168_pinmux_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= pxa168_pinmux_probe,
-	.remove	= __devexit_p(pxa168_pinmux_remove),
+	.remove	= pxa168_pinmux_remove,
 };
 
 static int __init pxa168_pinmux_init(void)
diff --git a/drivers/pinctrl/pinctrl-pxa910.c b/drivers/pinctrl/pinctrl-pxa910.c
index c72ab4b..ee2c861 100644
--- a/drivers/pinctrl/pinctrl-pxa910.c
+++ b/drivers/pinctrl/pinctrl-pxa910.c
@@ -987,7 +987,7 @@ static struct platform_driver pxa910_pinmux_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= pxa910_pinmux_probe,
-	.remove	= __devexit_p(pxa910_pinmux_remove),
+	.remove	= pxa910_pinmux_remove,
 };
 
 static int __init pxa910_pinmux_init(void)
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 726a729..a0d9584 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1006,7 +1006,7 @@ MODULE_DEVICE_TABLE(of, pcs_of_match);
 
 static struct platform_driver pcs_driver = {
 	.probe		= pcs_probe,
-	.remove		= __devexit_p(pcs_remove),
+	.remove		= pcs_remove,
 	.driver = {
 		.owner		= THIS_MODULE,
 		.name		= DRIVER_NAME,
diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index a74f9a5..e749ded 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -2873,7 +2873,7 @@ static struct platform_driver tegra20_pinctrl_driver = {
 		.of_match_table = tegra20_pinctrl_of_match,
 	},
 	.probe = tegra20_pinctrl_probe,
-	.remove = __devexit_p(tegra_pinctrl_remove),
+	.remove = tegra_pinctrl_remove,
 };
 
 static int __init tegra20_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index 7894f14..dc1e229 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -3739,7 +3739,7 @@ static struct platform_driver tegra30_pinctrl_driver = {
 		.of_match_table = tegra30_pinctrl_of_match,
 	},
 	.probe = tegra30_pinctrl_probe,
-	.remove = __devexit_p(tegra_pinctrl_remove),
+	.remove = tegra_pinctrl_remove,
 };
 
 static int __init tegra30_pinctrl_init(void)
diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index d756cce..6936474 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1158,7 +1158,7 @@ static struct platform_driver u300_pmx_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = u300_pmx_probe,
-	.remove = __devexit_p(u300_pmx_remove),
+	.remove = u300_pmx_remove,
 };
 
 static int __init u300_pmx_init(void)
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index 30134f7..d2237e4 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2716,7 +2716,7 @@ static struct platform_driver spear1310_pinctrl_driver = {
 		.of_match_table = spear1310_pinctrl_of_match,
 	},
 	.probe = spear1310_pinctrl_probe,
-	.remove = __devexit_p(spear1310_pinctrl_remove),
+	.remove = spear1310_pinctrl_remove,
 };
 
 static int __init spear1310_pinctrl_init(void)
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 0b4af0e..5202926 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -2032,7 +2032,7 @@ static struct platform_driver spear1340_pinctrl_driver = {
 		.of_match_table = spear1340_pinctrl_of_match,
 	},
 	.probe = spear1340_pinctrl_probe,
-	.remove = __devexit_p(spear1340_pinctrl_remove),
+	.remove = spear1340_pinctrl_remove,
 };
 
 static int __init spear1340_pinctrl_init(void)
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index 9a49100..5d8e3de 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -689,7 +689,7 @@ static struct platform_driver spear300_pinctrl_driver = {
 		.of_match_table = spear300_pinctrl_of_match,
 	},
 	.probe = spear300_pinctrl_probe,
-	.remove = __devexit_p(spear300_pinctrl_remove),
+	.remove = spear300_pinctrl_remove,
 };
 
 static int __init spear300_pinctrl_init(void)
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index 4d5dfe9..d583b30 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -412,7 +412,7 @@ static struct platform_driver spear310_pinctrl_driver = {
 		.of_match_table = spear310_pinctrl_of_match,
 	},
 	.probe = spear310_pinctrl_probe,
-	.remove = __devexit_p(spear310_pinctrl_remove),
+	.remove = spear310_pinctrl_remove,
 };
 
 static int __init spear310_pinctrl_init(void)
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index c996e26..9defbb4 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3453,7 +3453,7 @@ static struct platform_driver spear320_pinctrl_driver = {
 		.of_match_table = spear320_pinctrl_of_match,
 	},
 	.probe = spear320_pinctrl_probe,
-	.remove = __devexit_p(spear320_pinctrl_remove),
+	.remove = spear320_pinctrl_remove,
 };
 
 static int __init spear320_pinctrl_init(void)
-- 
1.8.0
