From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:22:24 -0500
Subject: [PATCH 195/493] pinctl: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com> 
Cc: Stephen Warren <swarren@wwwdotorg.org> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-rpi-kernel at lists.infradead.org 
Cc: spear-devel at list.st.com 
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  |  2 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c       |  2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   |  2 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      |  6 +++---
 drivers/pinctrl/pinctrl-at91.c             | 16 ++++++++--------
 drivers/pinctrl/pinctrl-bcm2835.c          |  2 +-
 drivers/pinctrl/pinctrl-imx.c              |  8 ++++----
 drivers/pinctrl/pinctrl-imx23.c            |  2 +-
 drivers/pinctrl/pinctrl-imx28.c            |  2 +-
 drivers/pinctrl/pinctrl-imx35.c            |  2 +-
 drivers/pinctrl/pinctrl-imx51.c            |  2 +-
 drivers/pinctrl/pinctrl-imx53.c            |  2 +-
 drivers/pinctrl/pinctrl-imx6q.c            |  2 +-
 drivers/pinctrl/pinctrl-mmp2.c             |  2 +-
 drivers/pinctrl/pinctrl-mxs.c              |  6 +++---
 drivers/pinctrl/pinctrl-nomadik-db8500.c   |  2 +-
 drivers/pinctrl/pinctrl-nomadik-db8540.c   |  2 +-
 drivers/pinctrl/pinctrl-nomadik-stn8815.c  |  2 +-
 drivers/pinctrl/pinctrl-nomadik.c          |  4 ++--
 drivers/pinctrl/pinctrl-pxa168.c           |  2 +-
 drivers/pinctrl/pinctrl-pxa910.c           |  2 +-
 drivers/pinctrl/pinctrl-samsung.c          | 12 ++++++------
 drivers/pinctrl/pinctrl-single.c           |  6 +++---
 drivers/pinctrl/pinctrl-sirf.c             |  4 ++--
 drivers/pinctrl/pinctrl-tegra.c            |  2 +-
 drivers/pinctrl/pinctrl-tegra20.c          |  2 +-
 drivers/pinctrl/pinctrl-tegra30.c          |  2 +-
 drivers/pinctrl/pinctrl-u300.c             |  2 +-
 drivers/pinctrl/pinctrl-xway.c             |  2 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c     |  4 ++--
 drivers/pinctrl/spear/pinctrl-spear.c      |  6 +++---
 drivers/pinctrl/spear/pinctrl-spear.h      |  6 +++---
 drivers/pinctrl/spear/pinctrl-spear1310.c  |  2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c  |  2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c   |  2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c   |  2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c   |  2 +-
 38 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 95cd5b1..384ab9c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -382,7 +382,7 @@ static struct pinctrl_gpio_range mv88f6710_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(2,  64, 64,  2),
 };
 
-static int __devinit armada_370_pinctrl_probe(struct platform_device *pdev)
+static int armada_370_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_370_pinctrl_info;
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index cfecf0c..02114b6 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -394,7 +394,7 @@ static struct pinctrl_gpio_range mv78460_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(2,  64, 64,  3),
 };
 
-static int __devinit armada_xp_pinctrl_probe(struct platform_device *pdev)
+static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_xp_pinctrl_info;
 	const struct of_device_id *match =
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 10d4472..608a9c6 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -576,7 +576,7 @@ static struct of_device_id dove_pinctrl_of_match[] __devinitdata = {
 	{ }
 };
 
-static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
+static int dove_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(dove_pinctrl_of_match, &pdev->dev);
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 506ca41..434ec8c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -442,7 +442,7 @@ static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
 	{ }
 };
 
-static int __devinit kirkwood_pinctrl_probe(struct platform_device *pdev)
+static int kirkwood_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match =
 		of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 6c44b7e..5d84015 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -478,7 +478,7 @@ static struct pinctrl_ops mvebu_pinctrl_ops = {
 	.dt_free_map = mvebu_pinctrl_dt_free_map,
 };
 
-static int __devinit _add_function(struct mvebu_pinctrl_function *funcs,
+static int _add_function(struct mvebu_pinctrl_function *funcs,
 				   const char *name)
 {
 	while (funcs->num_groups) {
@@ -494,7 +494,7 @@ static int __devinit _add_function(struct mvebu_pinctrl_function *funcs,
 	return 0;
 }
 
-static int __devinit mvebu_pinctrl_build_functions(struct platform_device *pdev,
+static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 						   struct mvebu_pinctrl *pctl)
 {
 	struct mvebu_pinctrl_function *funcs;
@@ -568,7 +568,7 @@ static int __devinit mvebu_pinctrl_build_functions(struct platform_device *pdev,
 	return 0;
 }
 
-int __devinit mvebu_pinctrl_probe(struct platform_device *pdev)
+int mvebu_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index c58aaac..72b69a9 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -681,7 +681,7 @@ static struct pinctrl_desc at91_pinctrl_desc = {
 
 static const char *gpio_compat = "atmel,at91rm9200-gpio";
 
-static void __devinit at91_pinctrl_child_count(struct at91_pinctrl *info,
+static void at91_pinctrl_child_count(struct at91_pinctrl *info,
 					      struct device_node *np)
 {
 	struct device_node *child;
@@ -696,7 +696,7 @@ static void __devinit at91_pinctrl_child_count(struct at91_pinctrl *info,
 	}
 }
 
-static int __devinit at91_pinctrl_mux_mask(struct at91_pinctrl *info,
+static int at91_pinctrl_mux_mask(struct at91_pinctrl *info,
 					  struct device_node *np)
 {
 	int ret = 0;
@@ -729,7 +729,7 @@ static int __devinit at91_pinctrl_mux_mask(struct at91_pinctrl *info,
 	return ret;
 }
 
-static int __devinit at91_pinctrl_parse_groups(struct device_node *np,
+static int at91_pinctrl_parse_groups(struct device_node *np,
 				struct at91_pin_group *grp,
 				struct at91_pinctrl *info,
 				u32 index)
@@ -778,7 +778,7 @@ static int __devinit at91_pinctrl_parse_groups(struct device_node *np,
 	return 0;
 }
 
-static int __devinit at91_pinctrl_parse_functions(struct device_node *np,
+static int at91_pinctrl_parse_functions(struct device_node *np,
 			struct at91_pinctrl *info, u32 index)
 {
 	struct device_node *child;
@@ -821,7 +821,7 @@ static struct of_device_id at91_pinctrl_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit at91_pinctrl_probe_dt(struct platform_device *pdev,
+static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 					   struct at91_pinctrl *info)
 {
 	int ret = 0;
@@ -888,7 +888,7 @@ static int __devinit at91_pinctrl_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
-static int __devinit at91_pinctrl_probe(struct platform_device *pdev)
+static int at91_pinctrl_probe(struct platform_device *pdev)
 {
 	struct at91_pinctrl *info;
 	struct pinctrl_pin_desc *pdesc;
@@ -1332,7 +1332,7 @@ static struct gpio_chip at91_gpio_template = {
 	.ngpio			= MAX_NB_GPIO_PER_BANK,
 };
 
-static void __devinit at91_gpio_probe_fixup(void)
+static void at91_gpio_probe_fixup(void)
 {
 	unsigned i;
 	struct at91_gpio_chip *at91_gpio, *last = NULL;
@@ -1356,7 +1356,7 @@ static struct of_device_id at91_gpio_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit at91_gpio_probe(struct platform_device *pdev)
+static int at91_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 9a963ed..98bc987 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -936,7 +936,7 @@ static struct pinctrl_gpio_range bcm2835_pinctrl_gpio_range __devinitconst = {
 	.npins = BCM2835_NUM_GPIOS,
 };
 
-static int __devinit bcm2835_pinctrl_probe(struct platform_device *pdev)
+static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index f3d2384..32bb2af 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -425,7 +425,7 @@ static int imx_pinctrl_get_pin_id_and_mux(const struct imx_pinctrl_soc_info *inf
 	return 0;
 }
 
-static int __devinit imx_pinctrl_parse_groups(struct device_node *np,
+static int imx_pinctrl_parse_groups(struct device_node *np,
 				struct imx_pin_group *grp,
 				struct imx_pinctrl_soc_info *info,
 				u32 index)
@@ -482,7 +482,7 @@ static int __devinit imx_pinctrl_parse_groups(struct device_node *np,
 	return 0;
 }
 
-static int __devinit imx_pinctrl_parse_functions(struct device_node *np,
+static int imx_pinctrl_parse_functions(struct device_node *np,
 			struct imx_pinctrl_soc_info *info, u32 index)
 {
 	struct device_node *child;
@@ -517,7 +517,7 @@ static int __devinit imx_pinctrl_parse_functions(struct device_node *np,
 	return 0;
 }
 
-static int __devinit imx_pinctrl_probe_dt(struct platform_device *pdev,
+static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 				struct imx_pinctrl_soc_info *info)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -560,7 +560,7 @@ static int __devinit imx_pinctrl_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
-int __devinit imx_pinctrl_probe(struct platform_device *pdev,
+int imx_pinctrl_probe(struct platform_device *pdev,
 				struct imx_pinctrl_soc_info *info)
 {
 	struct imx_pinctrl *ipctl;
diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index 67e1b3b..f445fa3 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -267,7 +267,7 @@ static struct mxs_pinctrl_soc_data imx23_pinctrl_data = {
 	.npins = ARRAY_SIZE(imx23_pins),
 };
 
-static int __devinit imx23_pinctrl_probe(struct platform_device *pdev)
+static int imx23_pinctrl_probe(struct platform_device *pdev)
 {
 	return mxs_pinctrl_probe(pdev, &imx23_pinctrl_data);
 }
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index feeb4b9..ef42677 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -383,7 +383,7 @@ static struct mxs_pinctrl_soc_data imx28_pinctrl_data = {
 	.npins = ARRAY_SIZE(imx28_pins),
 };
 
-static int __devinit imx28_pinctrl_probe(struct platform_device *pdev)
+static int imx28_pinctrl_probe(struct platform_device *pdev)
 {
 	return mxs_pinctrl_probe(pdev, &imx28_pinctrl_data);
 }
diff --git a/drivers/pinctrl/pinctrl-imx35.c b/drivers/pinctrl/pinctrl-imx35.c
index a88d087..4dfc88a 100644
--- a/drivers/pinctrl/pinctrl-imx35.c
+++ b/drivers/pinctrl/pinctrl-imx35.c
@@ -1564,7 +1564,7 @@ static struct of_device_id imx35_pinctrl_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit imx35_pinctrl_probe(struct platform_device *pdev)
+static int imx35_pinctrl_probe(struct platform_device *pdev)
 {
 	return imx_pinctrl_probe(pdev, &imx35_pinctrl_info);
 }
diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
index 5c48948..2455775 100644
--- a/drivers/pinctrl/pinctrl-imx51.c
+++ b/drivers/pinctrl/pinctrl-imx51.c
@@ -1291,7 +1291,7 @@ static struct of_device_id imx51_pinctrl_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit imx51_pinctrl_probe(struct platform_device *pdev)
+static int imx51_pinctrl_probe(struct platform_device *pdev)
 {
 	return imx_pinctrl_probe(pdev, &imx51_pinctrl_info);
 }
diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
index 8e5c15f..2b75b60 100644
--- a/drivers/pinctrl/pinctrl-imx53.c
+++ b/drivers/pinctrl/pinctrl-imx53.c
@@ -1618,7 +1618,7 @@ static struct of_device_id imx53_pinctrl_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit imx53_pinctrl_probe(struct platform_device *pdev)
+static int imx53_pinctrl_probe(struct platform_device *pdev)
 {
 	return imx_pinctrl_probe(pdev, &imx53_pinctrl_info);
 }
diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index 831dae6..7d4f249 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -2302,7 +2302,7 @@ static struct of_device_id imx6q_pinctrl_of_match[] __devinitdata = {
 	{ /* sentinel */ }
 };
 
-static int __devinit imx6q_pinctrl_probe(struct platform_device *pdev)
+static int imx6q_pinctrl_probe(struct platform_device *pdev)
 {
 	return imx_pinctrl_probe(pdev, &imx6q_pinctrl_info);
 }
diff --git a/drivers/pinctrl/pinctrl-mmp2.c b/drivers/pinctrl/pinctrl-mmp2.c
index a5159a3..f67a7e2 100644
--- a/drivers/pinctrl/pinctrl-mmp2.c
+++ b/drivers/pinctrl/pinctrl-mmp2.c
@@ -686,7 +686,7 @@ static struct pxa3xx_pinmux_info mmp2_info = {
 	.ds_shift	= MMP2_DS_SHIFT,
 };
 
-static int __devinit mmp2_pinmux_probe(struct platform_device *pdev)
+static int mmp2_pinmux_probe(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_register(pdev, &mmp2_info);
 }
diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index 3e7d4d6..8bc6b12 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -335,7 +335,7 @@ static struct pinctrl_desc mxs_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-static int __devinit mxs_pinctrl_parse_group(struct platform_device *pdev,
+static int mxs_pinctrl_parse_group(struct platform_device *pdev,
 					     struct device_node *np, int idx,
 					     const char **out_name)
 {
@@ -384,7 +384,7 @@ static int __devinit mxs_pinctrl_parse_group(struct platform_device *pdev,
 	return 0;
 }
 
-static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
+static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 					  struct mxs_pinctrl_data *d)
 {
 	struct mxs_pinctrl_soc_data *soc = d->soc;
@@ -476,7 +476,7 @@ static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
-int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
+int mxs_pinctrl_probe(struct platform_device *pdev,
 				struct mxs_pinctrl_soc_data *soc)
 {
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/pinctrl/pinctrl-nomadik-db8500.c b/drivers/pinctrl/pinctrl-nomadik-db8500.c
index 6de52e7..c12682f 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8500.c
@@ -1244,7 +1244,7 @@ static const struct nmk_pinctrl_soc_data nmk_db8500_soc = {
 	.prcm_gpiocr_registers = db8500_prcm_gpiocr_regs,
 };
 
-void __devinit
+void
 nmk_pinctrl_db8500_init(const struct nmk_pinctrl_soc_data **soc)
 {
 	*soc = &nmk_db8500_soc;
diff --git a/drivers/pinctrl/pinctrl-nomadik-db8540.c b/drivers/pinctrl/pinctrl-nomadik-db8540.c
index bce0583..c63632a 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8540.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8540.c
@@ -1255,7 +1255,7 @@ static const struct nmk_pinctrl_soc_data nmk_db8540_soc = {
 	.prcm_gpiocr_registers = db8540_prcm_gpiocr_regs,
 };
 
-void __devinit
+void
 nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc)
 {
 	*soc = &nmk_db8540_soc;
diff --git a/drivers/pinctrl/pinctrl-nomadik-stn8815.c b/drivers/pinctrl/pinctrl-nomadik-stn8815.c
index 7d432c3..221c18e 100644
--- a/drivers/pinctrl/pinctrl-nomadik-stn8815.c
+++ b/drivers/pinctrl/pinctrl-nomadik-stn8815.c
@@ -350,7 +350,7 @@ static const struct nmk_pinctrl_soc_data nmk_stn8815_soc = {
 	.ngroups = ARRAY_SIZE(nmk_stn8815_groups),
 };
 
-void __devinit
+void
 nmk_pinctrl_stn8815_init(const struct nmk_pinctrl_soc_data **soc)
 {
 	*soc = &nmk_stn8815_soc;
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 238060e..2f28ba3 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1306,7 +1306,7 @@ const struct irq_domain_ops nmk_gpio_irq_simple_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
-static int __devinit nmk_gpio_probe(struct platform_device *dev)
+static int nmk_gpio_probe(struct platform_device *dev)
 {
 	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
 	struct device_node *np = dev->dev.of_node;
@@ -1848,7 +1848,7 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 	{},
 };
 
-static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
+static int nmk_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/pinctrl/pinctrl-pxa168.c b/drivers/pinctrl/pinctrl-pxa168.c
index 4abab78..7fb7123 100644
--- a/drivers/pinctrl/pinctrl-pxa168.c
+++ b/drivers/pinctrl/pinctrl-pxa168.c
@@ -615,7 +615,7 @@ static struct pxa3xx_pinmux_info pxa168_info = {
 	.ds_shift	= PXA168_DS_SHIFT,
 };
 
-static int __devinit pxa168_pinmux_probe(struct platform_device *pdev)
+static int pxa168_pinmux_probe(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_register(pdev, &pxa168_info);
 }
diff --git a/drivers/pinctrl/pinctrl-pxa910.c b/drivers/pinctrl/pinctrl-pxa910.c
index ee2c861..e10664b 100644
--- a/drivers/pinctrl/pinctrl-pxa910.c
+++ b/drivers/pinctrl/pinctrl-pxa910.c
@@ -971,7 +971,7 @@ static struct pxa3xx_pinmux_info pxa910_info = {
 	.ds_shift	= PXA910_DS_SHIFT,
 };
 
-static int __devinit pxa910_pinmux_probe(struct platform_device *pdev)
+static int pxa910_pinmux_probe(struct platform_device *pdev)
 {
 	return pxa3xx_pinctrl_register(pdev, &pxa910_info);
 }
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 81c9896..70602c0 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -549,7 +549,7 @@ static int samsung_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
  * Parse the pin names listed in the 'samsung,pins' property and convert it
  * into a list of gpio numbers are create a pin group from it.
  */
-static int __devinit samsung_pinctrl_parse_dt_pins(struct platform_device *pdev,
+static int samsung_pinctrl_parse_dt_pins(struct platform_device *pdev,
 			struct device_node *cfg_np, struct pinctrl_desc *pctl,
 			unsigned int **pin_list, unsigned int *npins)
 {
@@ -596,7 +596,7 @@ static int __devinit samsung_pinctrl_parse_dt_pins(struct platform_device *pdev,
  * from device node of the pin-controller. A pin group is formed with all
  * the pins listed in the "samsung,pins" property.
  */
-static int __devinit samsung_pinctrl_parse_dt(struct platform_device *pdev,
+static int samsung_pinctrl_parse_dt(struct platform_device *pdev,
 				struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct device *dev = &pdev->dev;
@@ -691,7 +691,7 @@ static int __devinit samsung_pinctrl_parse_dt(struct platform_device *pdev,
 }
 
 /* register the pinctrl interface with the pinctrl subsystem */
-static int __devinit samsung_pinctrl_register(struct platform_device *pdev,
+static int samsung_pinctrl_register(struct platform_device *pdev,
 				struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct pinctrl_desc *ctrldesc = &drvdata->pctl;
@@ -778,7 +778,7 @@ static const struct gpio_chip samsung_gpiolib_chip = {
 };
 
 /* register the gpiolib interface with the gpiolib subsystem */
-static int __devinit samsung_gpiolib_register(struct platform_device *pdev,
+static int samsung_gpiolib_register(struct platform_device *pdev,
 				struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_ctrl *ctrl = drvdata->ctrl;
@@ -816,7 +816,7 @@ fail:
 }
 
 /* unregister the gpiolib interface with the gpiolib subsystem */
-static int __devinit samsung_gpiolib_unregister(struct platform_device *pdev,
+static int samsung_gpiolib_unregister(struct platform_device *pdev,
 				struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_ctrl *ctrl = drvdata->ctrl;
@@ -881,7 +881,7 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	return ctrl;
 }
 
-static int __devinit samsung_pinctrl_probe(struct platform_device *pdev)
+static int samsung_pinctrl_probe(struct platform_device *pdev)
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a0d9584..32272f2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -465,7 +465,7 @@ static struct pinconf_ops pcs_pinconf_ops = {
  * @pcs: pcs driver instance
  * @offset: register offset from base
  */
-static int __devinit pcs_add_pin(struct pcs_device *pcs, unsigned offset)
+static int pcs_add_pin(struct pcs_device *pcs, unsigned offset)
 {
 	struct pinctrl_pin_desc *pin;
 	struct pcs_name *pn;
@@ -498,7 +498,7 @@ static int __devinit pcs_add_pin(struct pcs_device *pcs, unsigned offset)
  * If your hardware needs holes in the address space, then just set
  * up multiple driver instances.
  */
-static int __devinit pcs_allocate_pin_table(struct pcs_device *pcs)
+static int pcs_allocate_pin_table(struct pcs_device *pcs)
 {
 	int mux_bytes, nr_pins, i;
 
@@ -879,7 +879,7 @@ static void pcs_free_resources(struct pcs_device *pcs)
 
 static struct of_device_id pcs_of_match[];
 
-static int __devinit pcs_probe(struct platform_device *pdev)
+static int pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index a3905e5..290caa3 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1246,7 +1246,7 @@ static void __iomem *sirfsoc_rsc_of_iomap(void)
 	return of_iomap(np, 0);
 }
 
-static int __devinit sirfsoc_pinmux_probe(struct platform_device *pdev)
+static int sirfsoc_pinmux_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct sirfsoc_pmx *spmx;
@@ -1663,7 +1663,7 @@ const struct irq_domain_ops sirfsoc_gpio_irq_simple_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
-static int __devinit sirfsoc_gpio_probe(struct device_node *np)
+static int sirfsoc_gpio_probe(struct device_node *np)
 {
 	int i, err = 0;
 	struct sirfsoc_gpio_bank *bank;
diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index f7fe91e..d624cfc 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -685,7 +685,7 @@ static struct pinctrl_desc tegra_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-int __devinit tegra_pinctrl_probe(struct platform_device *pdev,
+int tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data)
 {
 	struct tegra_pmx *pmx;
diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index e749ded..8bfecb4 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -2856,7 +2856,7 @@ static const struct tegra_pinctrl_soc_data tegra20_pinctrl = {
 	.ngroups = ARRAY_SIZE(tegra20_groups),
 };
 
-static int __devinit tegra20_pinctrl_probe(struct platform_device *pdev)
+static int tegra20_pinctrl_probe(struct platform_device *pdev)
 {
 	return tegra_pinctrl_probe(pdev, &tegra20_pinctrl);
 }
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index dc1e229..6973b7b 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -3722,7 +3722,7 @@ static const struct tegra_pinctrl_soc_data tegra30_pinctrl = {
 	.ngroups = ARRAY_SIZE(tegra30_groups),
 };
 
-static int __devinit tegra30_pinctrl_probe(struct platform_device *pdev)
+static int tegra30_pinctrl_probe(struct platform_device *pdev)
 {
 	return tegra_pinctrl_probe(pdev, &tegra30_pinctrl);
 }
diff --git a/drivers/pinctrl/pinctrl-u300.c b/drivers/pinctrl/pinctrl-u300.c
index 6936474..c96deb2 100644
--- a/drivers/pinctrl/pinctrl-u300.c
+++ b/drivers/pinctrl/pinctrl-u300.c
@@ -1101,7 +1101,7 @@ static struct pinctrl_desc u300_pmx_desc = {
 	.owner = THIS_MODULE,
 };
 
-static int __devinit u300_pmx_probe(struct platform_device *pdev)
+static int u300_pmx_probe(struct platform_device *pdev)
 {
 	struct u300_pmx *upmx;
 	struct resource *res;
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index ad90984..5f0eb04 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -674,7 +674,7 @@ static const struct of_device_id xway_match[] = {
 };
 MODULE_DEVICE_TABLE(of, xway_match);
 
-static int __devinit pinmux_xway_probe(struct platform_device *pdev)
+static int pinmux_xway_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	const struct pinctrl_xway_soc *xway_soc;
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 1044ad3..d792249 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -450,7 +450,7 @@ int spear310_o2p(int offset)
 		return offset + 2;
 }
 
-static int __devinit plgpio_probe_dt(struct platform_device *pdev,
+static int plgpio_probe_dt(struct platform_device *pdev,
 		struct plgpio *plgpio)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -521,7 +521,7 @@ static int __devinit plgpio_probe_dt(struct platform_device *pdev,
 end:
 	return ret;
 }
-static int __devinit plgpio_probe(struct platform_device *pdev)
+static int plgpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct plgpio *plgpio;
diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index f9483ae..bd5473c 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -82,7 +82,7 @@ static int set_mode(struct spear_pmx *pmx, int mode)
 	return 0;
 }
 
-void __devinit
+void
 pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
 		unsigned count, u16 reg)
 {
@@ -93,7 +93,7 @@ pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
 			gpio_pingroup[i].muxregs[j].reg = reg;
 }
 
-void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg)
+void pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg)
 {
 	struct spear_pingroup *pgroup;
 	struct spear_modemux *modemux;
@@ -356,7 +356,7 @@ static struct pinctrl_desc spear_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-int __devinit spear_pinctrl_probe(struct platform_device *pdev,
+int spear_pinctrl_probe(struct platform_device *pdev,
 		struct spear_pinctrl_machdata *machdata)
 {
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
index b063327..7e87652 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -192,11 +192,11 @@ static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
 	writel_relaxed(val, pmx->vbase + reg);
 }
 
-void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
-void __devinit
+void pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
+void
 pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
 		unsigned count, u16 reg);
-int __devinit spear_pinctrl_probe(struct platform_device *pdev,
+int spear_pinctrl_probe(struct platform_device *pdev,
 		struct spear_pinctrl_machdata *machdata);
 int __devexit spear_pinctrl_remove(struct platform_device *pdev);
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index d2237e4..b742946 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2699,7 +2699,7 @@ static struct of_device_id spear1310_pinctrl_of_match[] __devinitdata = {
 	{},
 };
 
-static int __devinit spear1310_pinctrl_probe(struct platform_device *pdev)
+static int spear1310_pinctrl_probe(struct platform_device *pdev)
 {
 	return spear_pinctrl_probe(pdev, &spear1310_machdata);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 5202926..4bc052e 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -2015,7 +2015,7 @@ static struct of_device_id spear1340_pinctrl_of_match[] __devinitdata = {
 	{},
 };
 
-static int __devinit spear1340_pinctrl_probe(struct platform_device *pdev)
+static int spear1340_pinctrl_probe(struct platform_device *pdev)
 {
 	return spear_pinctrl_probe(pdev, &spear1340_machdata);
 }
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index 5d8e3de..bdc2151 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -653,7 +653,7 @@ static struct of_device_id spear300_pinctrl_of_match[] __devinitdata = {
 	{},
 };
 
-static int __devinit spear300_pinctrl_probe(struct platform_device *pdev)
+static int spear300_pinctrl_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index d583b30..b8376fd 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -378,7 +378,7 @@ static struct of_device_id spear310_pinctrl_of_match[] __devinitdata = {
 	{},
 };
 
-static int __devinit spear310_pinctrl_probe(struct platform_device *pdev)
+static int spear310_pinctrl_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index 9defbb4..818c88d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3417,7 +3417,7 @@ static struct of_device_id spear320_pinctrl_of_match[] __devinitdata = {
 	{},
 };
 
-static int __devinit spear320_pinctrl_probe(struct platform_device *pdev)
+static int spear320_pinctrl_probe(struct platform_device *pdev)
 {
 	int ret;
 
-- 
1.8.0
