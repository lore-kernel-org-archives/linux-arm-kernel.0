From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:24:27 -0500
Subject: [PATCH 318/493] pinctrl: remove use of __devinitdata
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-318-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

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
 drivers/pinctrl/pinctrl-at91.c             | 4 ++--
 drivers/pinctrl/pinctrl-imx23.c            | 2 +-
 drivers/pinctrl/pinctrl-imx28.c            | 2 +-
 drivers/pinctrl/pinctrl-imx35.c            | 2 +-
 drivers/pinctrl/pinctrl-imx51.c            | 2 +-
 drivers/pinctrl/pinctrl-imx53.c            | 2 +-
 drivers/pinctrl/pinctrl-imx6q.c            | 2 +-
 drivers/pinctrl/pinctrl-single.c           | 2 +-
 drivers/pinctrl/pinctrl-tegra20.c          | 2 +-
 drivers/pinctrl/pinctrl-tegra30.c          | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c  | 2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c   | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 384ab9c..54a0cfc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -367,7 +367,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_370_pinctrl_info;
 
-static struct of_device_id armada_370_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id armada_370_pinctrl_of_match[] = {
 	{ .compatible = "marvell,mv88f6710-pinctrl" },
 	{ },
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 02114b6..b99c823 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -349,7 +349,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_xp_pinctrl_info;
 
-static struct of_device_id armada_xp_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id armada_xp_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv78230-pinctrl",
 		.data       = (void *) V_MV78230,
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 608a9c6..3d98011 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -571,7 +571,7 @@ static struct mvebu_pinctrl_soc_info dove_pinctrl_info = {
 
 static struct clk *clk;
 
-static struct of_device_id dove_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id dove_pinctrl_of_match[] = {
 	{ .compatible = "marvell,dove-pinctrl", .data = &dove_pinctrl_info },
 	{ }
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 434ec8c..970d56b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -433,7 +433,7 @@ static struct mvebu_pinctrl_soc_info mv88f6282_info = {
 	.ngpioranges = ARRAY_SIZE(mv88f628x_gpio_ranges),
 };
 
-static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id kirkwood_pinctrl_of_match[] = {
 	{ .compatible = "marvell,88f6180-pinctrl", .data = &mv88f6180_info },
 	{ .compatible = "marvell,88f6190-pinctrl", .data = &mv88f6190_info },
 	{ .compatible = "marvell,88f6192-pinctrl", .data = &mv88f6192_info },
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 72b69a9..2cb1df6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -815,7 +815,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	return 0;
 }
 
-static struct of_device_id at91_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id at91_pinctrl_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
 	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
@@ -1350,7 +1350,7 @@ static void at91_gpio_probe_fixup(void)
 	}
 }
 
-static struct of_device_id at91_gpio_of_match[] __devinitdata = {
+static struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index f445fa3..e76d75c 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -272,7 +272,7 @@ static int imx23_pinctrl_probe(struct platform_device *pdev)
 	return mxs_pinctrl_probe(pdev, &imx23_pinctrl_data);
 }
 
-static struct of_device_id imx23_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx23_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx23-pinctrl", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index ef42677..79c9c8d 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -388,7 +388,7 @@ static int imx28_pinctrl_probe(struct platform_device *pdev)
 	return mxs_pinctrl_probe(pdev, &imx28_pinctrl_data);
 }
 
-static struct of_device_id imx28_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx28_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx28-pinctrl", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx35.c b/drivers/pinctrl/pinctrl-imx35.c
index 4dfc88a..6e21411 100644
--- a/drivers/pinctrl/pinctrl-imx35.c
+++ b/drivers/pinctrl/pinctrl-imx35.c
@@ -1559,7 +1559,7 @@ static struct imx_pinctrl_soc_info imx35_pinctrl_info = {
 	.npin_regs = ARRAY_SIZE(imx35_pin_regs),
 };
 
-static struct of_device_id imx35_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx35_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx35-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
index 2455775..9a92aaa 100644
--- a/drivers/pinctrl/pinctrl-imx51.c
+++ b/drivers/pinctrl/pinctrl-imx51.c
@@ -1286,7 +1286,7 @@ static struct imx_pinctrl_soc_info imx51_pinctrl_info = {
 	.npin_regs = ARRAY_SIZE(imx51_pin_regs),
 };
 
-static struct of_device_id imx51_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx51_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx51-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
index 2b75b60..bfe0ba8 100644
--- a/drivers/pinctrl/pinctrl-imx53.c
+++ b/drivers/pinctrl/pinctrl-imx53.c
@@ -1613,7 +1613,7 @@ static struct imx_pinctrl_soc_info imx53_pinctrl_info = {
 	.npin_regs = ARRAY_SIZE(imx53_pin_regs),
 };
 
-static struct of_device_id imx53_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx53_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx53-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index 7d4f249..663346b 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -2297,7 +2297,7 @@ static struct imx_pinctrl_soc_info imx6q_pinctrl_info = {
 	.npin_regs = ARRAY_SIZE(imx6q_pin_regs),
 };
 
-static struct of_device_id imx6q_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id imx6q_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx6q-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 32272f2..0f2ee82 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -998,7 +998,7 @@ static int __devexit pcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id pcs_of_match[] __devinitdata = {
+static struct of_device_id pcs_of_match[] = {
 	{ .compatible = DRIVER_NAME, },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index 8bfecb4..e848189 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -2861,7 +2861,7 @@ static int tegra20_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra20_pinctrl);
 }
 
-static struct of_device_id tegra20_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id tegra20_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index 6973b7b..9ad87ea 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -3727,7 +3727,7 @@ static int tegra30_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra30_pinctrl);
 }
 
-static struct of_device_id tegra30_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id tegra30_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra30-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index b742946..e53fd36 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2692,7 +2692,7 @@ static struct spear_pinctrl_machdata spear1310_machdata = {
 	.modes_supported = false,
 };
 
-static struct of_device_id spear1310_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id spear1310_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear1310-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 4bc052e..a5d7a5f 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -2008,7 +2008,7 @@ static struct spear_pinctrl_machdata spear1340_machdata = {
 	.modes_supported = false,
 };
 
-static struct of_device_id spear1340_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id spear1340_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear1340-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index bdc2151..e9cd858 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -646,7 +646,7 @@ static struct spear_function *spear300_functions[] = {
 	&gpio1_function,
 };
 
-static struct of_device_id spear300_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id spear300_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear300-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index b8376fd..7e0e23d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -371,7 +371,7 @@ static struct spear_function *spear310_functions[] = {
 	&tdm_function,
 };
 
-static struct of_device_id spear310_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id spear310_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear310-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index 818c88d..6b2b03c 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3410,7 +3410,7 @@ static struct spear_function *spear320_functions[] = {
 	&i2c2_function,
 };
 
-static struct of_device_id spear320_pinctrl_of_match[] __devinitdata = {
+static struct of_device_id spear320_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear320-pinmux",
 	},
-- 
1.8.0
