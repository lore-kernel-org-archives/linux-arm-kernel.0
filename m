From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:26:06 -0500
Subject: [PATCH 417/493] pinctrl: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-417-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com> 
Cc: Stephen Warren <swarren@wwwdotorg.org> 
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-rpi-kernel at lists.infradead.org 
Cc: spear-devel at list.st.com 
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 2 +-
 drivers/pinctrl/pinctrl-at91.c             | 2 +-
 drivers/pinctrl/pinctrl-bcm2835.c          | 2 +-
 drivers/pinctrl/pinctrl-imx.c              | 2 +-
 drivers/pinctrl/pinctrl-mmp2.c             | 2 +-
 drivers/pinctrl/pinctrl-mxs.c              | 2 +-
 drivers/pinctrl/pinctrl-pxa168.c           | 2 +-
 drivers/pinctrl/pinctrl-pxa910.c           | 2 +-
 drivers/pinctrl/pinctrl-single.c           | 2 +-
 drivers/pinctrl/pinctrl-tegra.c            | 2 +-
 drivers/pinctrl/pinctrl-u300.c             | 2 +-
 drivers/pinctrl/spear/pinctrl-spear.c      | 2 +-
 drivers/pinctrl/spear/pinctrl-spear.h      | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c   | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 54a0cfc..48e21a2 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -399,7 +399,7 @@ static int armada_370_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int __devexit armada_370_pinctrl_remove(struct platform_device *pdev)
+static int armada_370_pinctrl_remove(struct platform_device *pdev)
 {
 	return mvebu_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index b99c823..ab5dc04 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -446,7 +446,7 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int __devexit armada_xp_pinctrl_remove(struct platform_device *pdev)
+static int armada_xp_pinctrl_remove(struct platform_device *pdev)
 {
 	return mvebu_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 3d98011..6b90fa2 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -593,7 +593,7 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int __devexit dove_pinctrl_remove(struct platform_device *pdev)
+static int dove_pinctrl_remove(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 970d56b..8b70411 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -450,7 +450,7 @@ static int kirkwood_pinctrl_probe(struct platform_device *pdev)
 	return mvebu_pinctrl_probe(pdev);
 }
 
-static int __devexit kirkwood_pinctrl_remove(struct platform_device *pdev)
+static int kirkwood_pinctrl_remove(struct platform_device *pdev)
 {
 	return mvebu_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 5d84015..dee9bda 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -745,7 +745,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-int __devexit mvebu_pinctrl_remove(struct platform_device *pdev)
+int mvebu_pinctrl_remove(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl *pctl = platform_get_drvdata(pdev);
 	pinctrl_unregister(pctl->pctldev);
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 2cb1df6..d813c75 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -952,7 +952,7 @@ err:
 	return ret;
 }
 
-static int __devexit at91_pinctrl_remove(struct platform_device *pdev)
+static int at91_pinctrl_remove(struct platform_device *pdev)
 {
 	struct at91_pinctrl *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 1ccef36..d347b9f 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -1042,7 +1042,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bcm2835_pinctrl_remove(struct platform_device *pdev)
+static int bcm2835_pinctrl_remove(struct platform_device *pdev)
 {
 	struct bcm2835_pinctrl *pc = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 32bb2af..aec7f54 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -611,7 +611,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	return 0;
 }
 
-int __devexit imx_pinctrl_remove(struct platform_device *pdev)
+int imx_pinctrl_remove(struct platform_device *pdev)
 {
 	struct imx_pinctrl *ipctl = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-mmp2.c b/drivers/pinctrl/pinctrl-mmp2.c
index f67a7e2..4afa56a 100644
--- a/drivers/pinctrl/pinctrl-mmp2.c
+++ b/drivers/pinctrl/pinctrl-mmp2.c
@@ -691,7 +691,7 @@ static int mmp2_pinmux_probe(struct platform_device *pdev)
 	return pxa3xx_pinctrl_register(pdev, &mmp2_info);
 }
 
-static int __devexit mmp2_pinmux_remove(struct platform_device *pdev)
+static int mmp2_pinmux_remove(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_unregister(pdev);
 }
diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index 8bc6b12..2baba35 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -522,7 +522,7 @@ err:
 }
 EXPORT_SYMBOL_GPL(mxs_pinctrl_probe);
 
-int __devexit mxs_pinctrl_remove(struct platform_device *pdev)
+int mxs_pinctrl_remove(struct platform_device *pdev)
 {
 	struct mxs_pinctrl_data *d = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-pxa168.c b/drivers/pinctrl/pinctrl-pxa168.c
index 7fb7123..d9cd2b4 100644
--- a/drivers/pinctrl/pinctrl-pxa168.c
+++ b/drivers/pinctrl/pinctrl-pxa168.c
@@ -620,7 +620,7 @@ static int pxa168_pinmux_probe(struct platform_device *pdev)
 	return pxa3xx_pinctrl_register(pdev, &pxa168_info);
 }
 
-static int __devexit pxa168_pinmux_remove(struct platform_device *pdev)
+static int pxa168_pinmux_remove(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_unregister(pdev);
 }
diff --git a/drivers/pinctrl/pinctrl-pxa910.c b/drivers/pinctrl/pinctrl-pxa910.c
index e10664b..a2f917b 100644
--- a/drivers/pinctrl/pinctrl-pxa910.c
+++ b/drivers/pinctrl/pinctrl-pxa910.c
@@ -976,7 +976,7 @@ static int pxa910_pinmux_probe(struct platform_device *pdev)
 	return pxa3xx_pinctrl_register(pdev, &pxa910_info);
 }
 
-static int __devexit pxa910_pinmux_remove(struct platform_device *pdev)
+static int pxa910_pinmux_remove(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_unregister(pdev);
 }
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 0f2ee82..8efb980 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -986,7 +986,7 @@ free:
 	return ret;
 }
 
-static int __devexit pcs_remove(struct platform_device *pdev)
+static int pcs_remove(struct platform_device *pdev)
 {
 	struct pcs_device *pcs = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index d624cfc..c87c35f 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -758,7 +758,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(tegra_pinctrl_probe);
 
-int __devexit tegra_pinctrl_remove(struct platform_device *pdev)
+int tegra_pinctrl_remove(struct platform_device *pdev)
 {
 	struct tegra_pmx *pmx = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index c96deb2..29545dc 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1142,7 +1142,7 @@ static int u300_pmx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit u300_pmx_remove(struct platform_device *pdev)
+static int u300_pmx_remove(struct platform_device *pdev)
 {
 	struct u300_pmx *upmx = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index bd5473c..4c20e7a 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -415,7 +415,7 @@ int spear_pinctrl_probe(struct platform_device *pdev,
 	return 0;
 }
 
-int __devexit spear_pinctrl_remove(struct platform_device *pdev)
+int spear_pinctrl_remove(struct platform_device *pdev)
 {
 	struct spear_pmx *pmx = platform_get_drvdata(pdev);
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
index 7e87652..06cb07d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -198,7 +198,7 @@ pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
 		unsigned count, u16 reg);
 int spear_pinctrl_probe(struct platform_device *pdev,
 		struct spear_pinctrl_machdata *machdata);
-int __devexit spear_pinctrl_remove(struct platform_device *pdev);
+int spear_pinctrl_remove(struct platform_device *pdev);
 
 #define SPEAR_PIN_0_TO_101		\
 	PINCTRL_PIN(0, "PLGPIO0"),	\
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index e53fd36..1a8bbfe 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2704,7 +2704,7 @@ static int spear1310_pinctrl_probe(struct platform_device *pdev)
 	return spear_pinctrl_probe(pdev, &spear1310_machdata);
 }
 
-static int __devexit spear1310_pinctrl_remove(struct platform_device *pdev)
+static int spear1310_pinctrl_remove(struct platform_device *pdev)
 {
 	return spear_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index a5d7a5f..873966e 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -2020,7 +2020,7 @@ static int spear1340_pinctrl_probe(struct platform_device *pdev)
 	return spear_pinctrl_probe(pdev, &spear1340_machdata);
 }
 
-static int __devexit spear1340_pinctrl_remove(struct platform_device *pdev)
+static int spear1340_pinctrl_remove(struct platform_device *pdev)
 {
 	return spear_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index e9cd858..4777c0d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -677,7 +677,7 @@ static int spear300_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit spear300_pinctrl_remove(struct platform_device *pdev)
+static int spear300_pinctrl_remove(struct platform_device *pdev)
 {
 	return spear_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index 7e0e23d..06c7e6f 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -400,7 +400,7 @@ static int spear310_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit spear310_pinctrl_remove(struct platform_device *pdev)
+static int spear310_pinctrl_remove(struct platform_device *pdev)
 {
 	return spear_pinctrl_remove(pdev);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index 6b2b03c..b8e290a 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3441,7 +3441,7 @@ static int spear320_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit spear320_pinctrl_remove(struct platform_device *pdev)
+static int spear320_pinctrl_remove(struct platform_device *pdev)
 {
 	return spear_pinctrl_remove(pdev);
 }
-- 
1.8.0
