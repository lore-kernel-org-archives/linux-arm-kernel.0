From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 10 Sep 2014 22:20:37 +0200
Subject: [PATCH] pinctrl: make of_device_ids const
Message-ID: <1410380437-17960-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. This allows to
mark all struct of_device_id below drivers/pinctrl const, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c        | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c    | 2 +-
 drivers/pinctrl/mvebu/pinctrl-orion.c       | 2 +-
 drivers/pinctrl/pinctrl-as3722.c            | 2 +-
 drivers/pinctrl/pinctrl-at91.c              | 4 ++--
 drivers/pinctrl/pinctrl-bcm281xx.c          | 2 +-
 drivers/pinctrl/pinctrl-bcm2835.c           | 2 +-
 drivers/pinctrl/pinctrl-imx23.c             | 2 +-
 drivers/pinctrl/pinctrl-imx25.c             | 2 +-
 drivers/pinctrl/pinctrl-imx27.c             | 2 +-
 drivers/pinctrl/pinctrl-imx28.c             | 2 +-
 drivers/pinctrl/pinctrl-imx35.c             | 2 +-
 drivers/pinctrl/pinctrl-imx50.c             | 2 +-
 drivers/pinctrl/pinctrl-imx51.c             | 2 +-
 drivers/pinctrl/pinctrl-imx53.c             | 2 +-
 drivers/pinctrl/pinctrl-imx6dl.c            | 2 +-
 drivers/pinctrl/pinctrl-imx6q.c             | 2 +-
 drivers/pinctrl/pinctrl-imx6sl.c            | 2 +-
 drivers/pinctrl/pinctrl-imx6sx.c            | 2 +-
 drivers/pinctrl/pinctrl-palmas.c            | 2 +-
 drivers/pinctrl/pinctrl-single.c            | 4 ++--
 drivers/pinctrl/pinctrl-st.c                | 2 +-
 drivers/pinctrl/pinctrl-tegra114.c          | 2 +-
 drivers/pinctrl/pinctrl-tegra124.c          | 2 +-
 drivers/pinctrl/pinctrl-tegra20.c           | 2 +-
 drivers/pinctrl/pinctrl-tegra30.c           | 2 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c        | 2 +-
 drivers/pinctrl/pinctrl-tz1090.c            | 2 +-
 drivers/pinctrl/pinctrl-vf610.c             | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c   | 2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c    | 2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c    | 2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c    | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c   | 2 +-
 drivers/pinctrl/vt8500/pinctrl-vt8500.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8505.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8650.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8750.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8850.c     | 2 +-
 51 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 670e5b01c678..6d4c348dfbf2 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -379,7 +379,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_370_pinctrl_info;
 
-static struct of_device_id armada_370_pinctrl_of_match[] = {
+static const struct of_device_id armada_370_pinctrl_of_match[] = {
 	{ .compatible = "marvell,mv88f6710-pinctrl" },
 	{ },
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index db078fe7ace6..ba3f538a16d5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -399,7 +399,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_375_pinctrl_info;
 
-static struct of_device_id armada_375_pinctrl_of_match[] = {
+static const struct of_device_id armada_375_pinctrl_of_match[] = {
 	{ .compatible = "marvell,mv88f6720-pinctrl" },
 	{ },
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 1049f82fb62f..a95d1a5d0cf4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -387,7 +387,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_38x_pinctrl_info;
 
-static struct of_device_id armada_38x_pinctrl_of_match[] = {
+static const struct of_device_id armada_38x_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv88f6810-pinctrl",
 		.data       = (void *) V_88F6810,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index de311129f7a0..44066da21d40 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -361,7 +361,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_xp_pinctrl_info;
 
-static struct of_device_id armada_xp_pinctrl_of_match[] = {
+static const struct of_device_id armada_xp_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv78230-pinctrl",
 		.data       = (void *) V_MV78230,
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 3b022178a566..b9348c8cb474 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -751,7 +751,7 @@ static struct mvebu_pinctrl_soc_info dove_pinctrl_info = {
 
 static struct clk *clk;
 
-static struct of_device_id dove_pinctrl_of_match[] = {
+static const struct of_device_id dove_pinctrl_of_match[] = {
 	{ .compatible = "marvell,dove-pinctrl", .data = &dove_pinctrl_info },
 	{ }
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 0d0211a1a0b0..2f3c2927527d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -456,7 +456,7 @@ static struct mvebu_pinctrl_soc_info mv98dx4122_info = {
 	.ngpioranges = ARRAY_SIZE(mv88f628x_gpio_ranges),
 };
 
-static struct of_device_id kirkwood_pinctrl_of_match[] = {
+static const struct of_device_id kirkwood_pinctrl_of_match[] = {
 	{ .compatible = "marvell,88f6180-pinctrl", .data = &mv88f6180_info },
 	{ .compatible = "marvell,88f6190-pinctrl", .data = &mv88f6190_info },
 	{ .compatible = "marvell,88f6192-pinctrl", .data = &mv88f6192_info },
diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
index dda1e7254e15..f0a329c637d6 100644
--- a/drivers/pinctrl/mvebu/pinctrl-orion.c
+++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
@@ -211,7 +211,7 @@ static struct mvebu_pinctrl_soc_info mv88f5281_info = {
  * There are multiple variants of the Orion SoCs, but in terms of pin
  * muxing, they are identical.
  */
-static struct of_device_id orion_pinctrl_of_match[] = {
+static const struct of_device_id orion_pinctrl_of_match[] = {
 	{ .compatible = "marvell,88f5181l-pinctrl", .data = &mv88f5181l_info },
 	{ .compatible = "marvell,88f5182-pinctrl", .data = &mv88f5182_info },
 	{ .compatible = "marvell,88f5281-pinctrl", .data = &mv88f5281_info },
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 0e4ec91f4d49..67fed878e0c5 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -625,7 +625,7 @@ static int as3722_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id as3722_pinctrl_of_match[] = {
+static const struct of_device_id as3722_pinctrl_of_match[] = {
 	{ .compatible = "ams,as3722-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 60464a2648aa..d97712ff700b 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -944,7 +944,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	return 0;
 }
 
-static struct of_device_id at91_pinctrl_of_match[] = {
+static const struct of_device_id at91_pinctrl_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
 	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
@@ -1526,7 +1526,7 @@ static void at91_gpio_probe_fixup(void)
 	}
 }
 
-static struct of_device_id at91_gpio_of_match[] = {
+static const struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
diff --git a/drivers/pinctrl/pinctrl-bcm281xx.c b/drivers/pinctrl/pinctrl-bcm281xx.c
index c5ca9e633fff..045ebb18b4f9 100644
--- a/drivers/pinctrl/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/pinctrl-bcm281xx.c
@@ -1440,7 +1440,7 @@ static int __init bcm281xx_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id bcm281xx_pinctrl_of_match[] = {
+static const struct of_device_id bcm281xx_pinctrl_of_match[] = {
 	{ .compatible = "brcm,bcm11351-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 5bcfd7ace0cd..875461d1a8e7 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -1051,7 +1051,7 @@ static int bcm2835_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id bcm2835_pinctrl_match[] = {
+static const struct of_device_id bcm2835_pinctrl_match[] = {
 	{ .compatible = "brcm,bcm2835-gpio" },
 	{}
 };
diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index e76d75c9d1ba..df79096becb0 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -272,7 +272,7 @@ static int imx23_pinctrl_probe(struct platform_device *pdev)
 	return mxs_pinctrl_probe(pdev, &imx23_pinctrl_data);
 }
 
-static struct of_device_id imx23_pinctrl_of_match[] = {
+static const struct of_device_id imx23_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx23-pinctrl", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx25.c b/drivers/pinctrl/pinctrl-imx25.c
index 1aae1b61c4dc..550e6d77ac2b 100644
--- a/drivers/pinctrl/pinctrl-imx25.c
+++ b/drivers/pinctrl/pinctrl-imx25.c
@@ -315,7 +315,7 @@ static struct imx_pinctrl_soc_info imx25_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx25_pinctrl_pads),
 };
 
-static struct of_device_id imx25_pinctrl_of_match[] = {
+static const struct of_device_id imx25_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx25-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx27.c b/drivers/pinctrl/pinctrl-imx27.c
index f8dfefb69968..945eccadea74 100644
--- a/drivers/pinctrl/pinctrl-imx27.c
+++ b/drivers/pinctrl/pinctrl-imx27.c
@@ -389,7 +389,7 @@ static struct imx1_pinctrl_soc_info imx27_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx27_pinctrl_pads),
 };
 
-static struct of_device_id imx27_pinctrl_of_match[] = {
+static const struct of_device_id imx27_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx27-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index 79c9c8d296af..3bd45da21229 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -388,7 +388,7 @@ static int imx28_pinctrl_probe(struct platform_device *pdev)
 	return mxs_pinctrl_probe(pdev, &imx28_pinctrl_data);
 }
 
-static struct of_device_id imx28_pinctrl_of_match[] = {
+static const struct of_device_id imx28_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx28-pinctrl", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx35.c b/drivers/pinctrl/pinctrl-imx35.c
index 278a04ae8940..6bfbcd0112c1 100644
--- a/drivers/pinctrl/pinctrl-imx35.c
+++ b/drivers/pinctrl/pinctrl-imx35.c
@@ -1005,7 +1005,7 @@ static struct imx_pinctrl_soc_info imx35_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx35_pinctrl_pads),
 };
 
-static struct of_device_id imx35_pinctrl_of_match[] = {
+static const struct of_device_id imx35_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx35-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx50.c b/drivers/pinctrl/pinctrl-imx50.c
index b06feed1b038..e8bd604ab147 100644
--- a/drivers/pinctrl/pinctrl-imx50.c
+++ b/drivers/pinctrl/pinctrl-imx50.c
@@ -391,7 +391,7 @@ static struct imx_pinctrl_soc_info imx50_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx50_pinctrl_pads),
 };
 
-static struct of_device_id imx50_pinctrl_of_match[] = {
+static const struct of_device_id imx50_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx50-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
index 19ab182bef61..b818051db7c9 100644
--- a/drivers/pinctrl/pinctrl-imx51.c
+++ b/drivers/pinctrl/pinctrl-imx51.c
@@ -768,7 +768,7 @@ static struct imx_pinctrl_soc_info imx51_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx51_pinctrl_pads),
 };
 
-static struct of_device_id imx51_pinctrl_of_match[] = {
+static const struct of_device_id imx51_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx51-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
index f8d45c4cfde7..1884d53cf750 100644
--- a/drivers/pinctrl/pinctrl-imx53.c
+++ b/drivers/pinctrl/pinctrl-imx53.c
@@ -454,7 +454,7 @@ static struct imx_pinctrl_soc_info imx53_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx53_pinctrl_pads),
 };
 
-static struct of_device_id imx53_pinctrl_of_match[] = {
+static const struct of_device_id imx53_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx53-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx6dl.c b/drivers/pinctrl/pinctrl-imx6dl.c
index db2a1489bd99..656c4b08cc2e 100644
--- a/drivers/pinctrl/pinctrl-imx6dl.c
+++ b/drivers/pinctrl/pinctrl-imx6dl.c
@@ -460,7 +460,7 @@ static struct imx_pinctrl_soc_info imx6dl_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx6dl_pinctrl_pads),
 };
 
-static struct of_device_id imx6dl_pinctrl_of_match[] = {
+static const struct of_device_id imx6dl_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx6dl-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index 8eb5ac1bd5f6..59bb5b4ec0f6 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -466,7 +466,7 @@ static struct imx_pinctrl_soc_info imx6q_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx6q_pinctrl_pads),
 };
 
-static struct of_device_id imx6q_pinctrl_of_match[] = {
+static const struct of_device_id imx6q_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx6q-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx6sl.c b/drivers/pinctrl/pinctrl-imx6sl.c
index f21b7389df3c..fa76d6cb15cf 100644
--- a/drivers/pinctrl/pinctrl-imx6sl.c
+++ b/drivers/pinctrl/pinctrl-imx6sl.c
@@ -366,7 +366,7 @@ static struct imx_pinctrl_soc_info imx6sl_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx6sl_pinctrl_pads),
 };
 
-static struct of_device_id imx6sl_pinctrl_of_match[] = {
+static const struct of_device_id imx6sl_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx6sl-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-imx6sx.c b/drivers/pinctrl/pinctrl-imx6sx.c
index 09758a56b9df..840344c8580d 100644
--- a/drivers/pinctrl/pinctrl-imx6sx.c
+++ b/drivers/pinctrl/pinctrl-imx6sx.c
@@ -370,7 +370,7 @@ static struct imx_pinctrl_soc_info imx6sx_pinctrl_info = {
 	.npins = ARRAY_SIZE(imx6sx_pinctrl_pads),
 };
 
-static struct of_device_id imx6sx_pinctrl_of_match[] = {
+static const struct of_device_id imx6sx_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx6sx-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index f13d0e78a41c..1f21aae0151e 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -986,7 +986,7 @@ static struct palmas_pinctrl_data tps80036_pinctrl_data = {
 	.num_pin_groups = ARRAY_SIZE(tps80036_pingroups),
 };
 
-static struct of_device_id palmas_pinctrl_of_match[] = {
+static const struct of_device_id palmas_pinctrl_of_match[] = {
 	{ .compatible = "ti,palmas-pinctrl", .data = &tps65913_pinctrl_data},
 	{ .compatible = "ti,tps65913-pinctrl", .data = &tps65913_pinctrl_data},
 	{ .compatible = "ti,tps80036-pinctrl", .data = &tps80036_pinctrl_data},
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 95dd9cf55cb3..fee82c0590fc 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1501,7 +1501,7 @@ static void pcs_free_resources(struct pcs_device *pcs)
 		}							\
 	} while (0);
 
-static struct of_device_id pcs_of_match[];
+static const struct of_device_id pcs_of_match[];
 
 static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 {
@@ -1988,7 +1988,7 @@ static const struct pcs_soc_data pinconf_single = {
 	.flags = PCS_FEAT_PINCONF,
 };
 
-static struct of_device_id pcs_of_match[] = {
+static const struct of_device_id pcs_of_match[] = {
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 5475374d803f..0c70e3c1aab6 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1527,7 +1527,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
 	return 0;
 }
 
-static struct of_device_id st_pctl_of_match[] = {
+static const struct of_device_id st_pctl_of_match[] = {
 	{ .compatible = "st,stih415-sbc-pinctrl", .data = &stih415_sbc_data },
 	{ .compatible = "st,stih415-rear-pinctrl", .data = &stih415_rear_data },
 	{ .compatible = "st,stih415-left-pinctrl", .data = &stih415_left_data },
diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 33614baab4c0..a3db85b0b75f 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -1850,7 +1850,7 @@ static int tegra114_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra114_pinctrl);
 }
 
-static struct of_device_id tegra114_pinctrl_of_match[] = {
+static const struct of_device_id tegra114_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra114-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tegra124.c b/drivers/pinctrl/pinctrl-tegra124.c
index e80797e20017..cb3e596cade1 100644
--- a/drivers/pinctrl/pinctrl-tegra124.c
+++ b/drivers/pinctrl/pinctrl-tegra124.c
@@ -1996,7 +1996,7 @@ static int tegra124_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra124_pinctrl);
 }
 
-static struct of_device_id tegra124_pinctrl_of_match[] = {
+static const struct of_device_id tegra124_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra124-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index 7563ebc9c791..c9805d2e71b0 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -2228,7 +2228,7 @@ static int tegra20_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra20_pinctrl);
 }
 
-static struct of_device_id tegra20_pinctrl_of_match[] = {
+static const struct of_device_id tegra20_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index fe2d2cf78ad9..e7b72e916558 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -2484,7 +2484,7 @@ static int tegra30_pinctrl_probe(struct platform_device *pdev)
 	return tegra_pinctrl_probe(pdev, &tegra30_pinctrl);
 }
 
-static struct of_device_id tegra30_pinctrl_of_match[] = {
+static const struct of_device_id tegra30_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra30-pinmux", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tz1090-pdc.c b/drivers/pinctrl/pinctrl-tz1090-pdc.c
index 41e81a35cabb..e3e6d3315974 100644
--- a/drivers/pinctrl/pinctrl-tz1090-pdc.c
+++ b/drivers/pinctrl/pinctrl-tz1090-pdc.c
@@ -968,7 +968,7 @@ static int tz1090_pdc_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tz1090_pdc_pinctrl_of_match[] = {
+static const struct of_device_id tz1090_pdc_pinctrl_of_match[] = {
 	{ .compatible = "img,tz1090-pdc-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tz1090.c b/drivers/pinctrl/pinctrl-tz1090.c
index 24082216842e..164d8553d016 100644
--- a/drivers/pinctrl/pinctrl-tz1090.c
+++ b/drivers/pinctrl/pinctrl-tz1090.c
@@ -1984,7 +1984,7 @@ static int tz1090_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tz1090_pinctrl_of_match[] = {
+static const struct of_device_id tz1090_pinctrl_of_match[] = {
 	{ .compatible = "img,tz1090-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-vf610.c b/drivers/pinctrl/pinctrl-vf610.c
index bddd913d28ba..5f307a5f2c95 100644
--- a/drivers/pinctrl/pinctrl-vf610.c
+++ b/drivers/pinctrl/pinctrl-vf610.c
@@ -302,7 +302,7 @@ static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
 };
 
-static struct of_device_id vf610_pinctrl_of_match[] = {
+static const struct of_device_id vf610_pinctrl_of_match[] = {
 	{ .compatible = "fsl,vf610-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index 1a8bbfec60ca..6d57d43ab640 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2692,7 +2692,7 @@ static struct spear_pinctrl_machdata spear1310_machdata = {
 	.modes_supported = false,
 };
 
-static struct of_device_id spear1310_pinctrl_of_match[] = {
+static const struct of_device_id spear1310_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear1310-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 873966e2b99f..d243e43e7f6d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -2008,7 +2008,7 @@ static struct spear_pinctrl_machdata spear1340_machdata = {
 	.modes_supported = false,
 };
 
-static struct of_device_id spear1340_pinctrl_of_match[] = {
+static const struct of_device_id spear1340_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear1340-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index 4777c0d0e730..9db83e9ee18c 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -646,7 +646,7 @@ static struct spear_function *spear300_functions[] = {
 	&gpio1_function,
 };
 
-static struct of_device_id spear300_pinctrl_of_match[] = {
+static const struct of_device_id spear300_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear300-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index ed1d3608f486..db775a414b7a 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -371,7 +371,7 @@ static struct spear_function *spear310_functions[] = {
 	&tdm_function,
 };
 
-static struct of_device_id spear310_pinctrl_of_match[] = {
+static const struct of_device_id spear310_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear310-pinmux",
 	},
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index b8e290a8c8c9..80fbd68e17bc 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3410,7 +3410,7 @@ static struct spear_function *spear320_functions[] = {
 	&i2c2_function,
 };
 
-static struct of_device_id spear320_pinctrl_of_match[] = {
+static const struct of_device_id spear320_pinctrl_of_match[] = {
 	{
 		.compatible = "st,spear320-pinmux",
 	},
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 86b608bedca6..849586763669 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -1019,7 +1019,7 @@ static int sun4i_a10_pinctrl_probe(struct platform_device *pdev)
 				  &sun4i_a10_pinctrl_data);
 }
 
-static struct of_device_id sun4i_a10_pinctrl_match[] = {
+static const struct of_device_id sun4i_a10_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
index 2fa7430cabaf..36762d5681a5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
@@ -670,7 +670,7 @@ static int sun5i_a10s_pinctrl_probe(struct platform_device *pdev)
 				  &sun5i_a10s_pinctrl_data);
 }
 
-static struct of_device_id sun5i_a10s_pinctrl_match[] = {
+static const struct of_device_id sun5i_a10s_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun5i-a10s-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
index e47c33dbae3a..274df79dd08a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
@@ -388,7 +388,7 @@ static int sun5i_a13_pinctrl_probe(struct platform_device *pdev)
 				  &sun5i_a13_pinctrl_data);
 }
 
-static struct of_device_id sun5i_a13_pinctrl_match[] = {
+static const struct of_device_id sun5i_a13_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun5i-a13-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index 9a2517b65113..f216764725e3 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -120,7 +120,7 @@ static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct of_device_id sun6i_a31_r_pinctrl_match[] = {
+static const struct of_device_id sun6i_a31_r_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-r-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index a2b4b85c5ad5..a03f0928be99 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -917,7 +917,7 @@ static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
 				  &sun6i_a31_pinctrl_data);
 }
 
-static struct of_device_id sun6i_a31_pinctrl_match[] = {
+static const struct of_device_id sun6i_a31_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index dac99e02bfdb..00e2a7f6ccd0 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
@@ -1045,7 +1045,7 @@ static int sun7i_a20_pinctrl_probe(struct platform_device *pdev)
 				  &sun7i_a20_pinctrl_data);
 }
 
-static struct of_device_id sun7i_a20_pinctrl_match[] = {
+static const struct of_device_id sun7i_a20_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 90f3b3a7c51e..c525f6da4358 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -119,7 +119,7 @@ static int sun8i_a23_r_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct of_device_id sun8i_a23_r_pinctrl_match[] = {
+static const struct of_device_id sun8i_a23_r_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-r-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
index ac71e8c5901b..efa018e86f64 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
@@ -571,7 +571,7 @@ static int sun8i_a23_pinctrl_probe(struct platform_device *pdev)
 				  &sun8i_a23_pinctrl_data);
 }
 
-static struct of_device_id sun8i_a23_pinctrl_match[] = {
+static const struct of_device_id sun8i_a23_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-vt8500.c b/drivers/pinctrl/vt8500/pinctrl-vt8500.c
index f2fe9f85cfa6..a64a1941fd7e 100644
--- a/drivers/pinctrl/vt8500/pinctrl-vt8500.c
+++ b/drivers/pinctrl/vt8500/pinctrl-vt8500.c
@@ -478,7 +478,7 @@ static int vt8500_pinctrl_remove(struct platform_device *pdev)
 	return wmt_pinctrl_remove(pdev);
 }
 
-static struct of_device_id wmt_pinctrl_of_match[] = {
+static const struct of_device_id wmt_pinctrl_of_match[] = {
 	{ .compatible = "via,vt8500-pinctrl" },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-wm8505.c b/drivers/pinctrl/vt8500/pinctrl-wm8505.c
index 483ba732694e..2757965f2120 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wm8505.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wm8505.c
@@ -509,7 +509,7 @@ static int wm8505_pinctrl_remove(struct platform_device *pdev)
 	return wmt_pinctrl_remove(pdev);
 }
 
-static struct of_device_id wmt_pinctrl_of_match[] = {
+static const struct of_device_id wmt_pinctrl_of_match[] = {
 	{ .compatible = "wm,wm8505-pinctrl" },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-wm8650.c b/drivers/pinctrl/vt8500/pinctrl-wm8650.c
index 7de57f063153..7047c64d8ed3 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wm8650.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wm8650.c
@@ -347,7 +347,7 @@ static int wm8650_pinctrl_remove(struct platform_device *pdev)
 	return wmt_pinctrl_remove(pdev);
 }
 
-static struct of_device_id wmt_pinctrl_of_match[] = {
+static const struct of_device_id wmt_pinctrl_of_match[] = {
 	{ .compatible = "wm,wm8650-pinctrl" },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-wm8750.c b/drivers/pinctrl/vt8500/pinctrl-wm8750.c
index de43262398db..0eb4264068d3 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wm8750.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wm8750.c
@@ -386,7 +386,7 @@ static int wm8750_pinctrl_remove(struct platform_device *pdev)
 	return wmt_pinctrl_remove(pdev);
 }
 
-static struct of_device_id wmt_pinctrl_of_match[] = {
+static const struct of_device_id wmt_pinctrl_of_match[] = {
 	{ .compatible = "wm,wm8750-pinctrl" },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-wm8850.c b/drivers/pinctrl/vt8500/pinctrl-wm8850.c
index ecadce9c91d5..4b1399e82dcc 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wm8850.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wm8850.c
@@ -365,7 +365,7 @@ static int wm8850_pinctrl_remove(struct platform_device *pdev)
 	return wmt_pinctrl_remove(pdev);
 }
 
-static struct of_device_id wmt_pinctrl_of_match[] = {
+static const struct of_device_id wmt_pinctrl_of_match[] = {
 	{ .compatible = "wm,wm8850-pinctrl" },
 	{ /* sentinel */ },
 };
-- 
2.1.0
