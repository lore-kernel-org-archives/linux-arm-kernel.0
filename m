From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:59:09 +0100
Subject: [PATCH 35/35 linux-next] pinctrl: constify of_device_id array
In-Reply-To: <1426535949-26107-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
Message-ID: <1426535949-26107-4-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c       | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c   | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c    | 2 +-
 drivers/pinctrl/mvebu/pinctrl-orion.c       | 2 +-
 drivers/pinctrl/pinctrl-as3722.c            | 2 +-
 drivers/pinctrl/pinctrl-at91.c              | 4 ++--
 drivers/pinctrl/pinctrl-palmas.c            | 2 +-
 drivers/pinctrl/pinctrl-single.c            | 4 ++--
 drivers/pinctrl/pinctrl-st.c                | 2 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c        | 2 +-
 drivers/pinctrl/pinctrl-tz1090.c            | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c  | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c   | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   | 2 +-
 drivers/pinctrl/vt8500/pinctrl-vt8500.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8505.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8650.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8750.c     | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wm8850.c     | 2 +-
 32 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 9aa8a3f..4d08b85 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1051,7 +1051,7 @@ static int bcm2835_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id bcm2835_pinctrl_match[] = {
+static const struct of_device_id bcm2835_pinctrl_match[] = {
 	{ .compatible = "brcm,bcm2835-gpio" },
 	{}
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 1296d6d..82c4af4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -347,7 +347,7 @@ static int mt8135_pinctrl_probe(struct platform_device *pdev)
 	return mtk_pctrl_init(pdev, &mt8135_pinctrl_data);
 }
 
-static struct of_device_id mt8135_pctrl_match[] = {
+static const struct of_device_id mt8135_pctrl_match[] = {
 	{
 		.compatible = "mediatek,mt8135-pinctrl",
 	}, {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index f07cafb..594f7b5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -427,7 +427,7 @@ static int mt8173_pinctrl_probe(struct platform_device *pdev)
 	return mtk_pctrl_init(pdev, &mt8173_pinctrl_data);
 }
 
-static struct of_device_id mt8173_pctrl_match[] = {
+static const struct of_device_id mt8173_pctrl_match[] = {
 	{
 		.compatible = "mediatek,mt8173-pinctrl",
 	}, {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index c4f51d0..42f930f 100644
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
index cd7c8f5..ca1e757 100644
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
index 7302f66..83bbcc7 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -389,7 +389,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_38x_pinctrl_info;
 
-static struct of_device_id armada_38x_pinctrl_of_match[] = {
+static const struct of_device_id armada_38x_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv88f6810-pinctrl",
 		.data       = (void *) V_88F6810,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 5963411..4249162 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -362,7 +362,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_39x_pinctrl_info;
 
-static struct of_device_id armada_39x_pinctrl_of_match[] = {
+static const struct of_device_id armada_39x_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv88f6920-pinctrl",
 		.data       = (void *) V_88F6920,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index fc33761..7daedc1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -361,7 +361,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_xp_pinctrl_info;
 
-static struct of_device_id armada_xp_pinctrl_of_match[] = {
+static const struct of_device_id armada_xp_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv78230-pinctrl",
 		.data       = (void *) V_MV78230,
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index dbc673c..0f07dc5 100644
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
index 3a632ef..3b7122d 100644
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
index 169b1bf..db0571f 100644
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
index 6f1eba3..6b32817 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1114,7 +1114,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	return 0;
 }
 
-static struct of_device_id at91_pinctrl_of_match[] = {
+static const struct of_device_id at91_pinctrl_of_match[] = {
 	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
 	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
 	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
@@ -1690,7 +1690,7 @@ static struct gpio_chip at91_gpio_template = {
 	.ngpio			= MAX_NB_GPIO_PER_BANK,
 };
 
-static struct of_device_id at91_gpio_of_match[] = {
+static const struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index 26461e3..2631df0 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -987,7 +987,7 @@ static struct palmas_pinctrl_data tps80036_pinctrl_data = {
 	.num_pin_groups = ARRAY_SIZE(tps80036_pingroups),
 };
 
-static struct of_device_id palmas_pinctrl_of_match[] = {
+static const struct of_device_id palmas_pinctrl_of_match[] = {
 	{ .compatible = "ti,palmas-pinctrl", .data = &tps65913_pinctrl_data},
 	{ .compatible = "ti,tps65913-pinctrl", .data = &tps65913_pinctrl_data},
 	{ .compatible = "ti,tps80036-pinctrl", .data = &tps80036_pinctrl_data},
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 69e8442..13b45f2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1501,7 +1501,7 @@ static void pcs_free_resources(struct pcs_device *pcs)
 		}							\
 	} while (0);
 
-static struct of_device_id pcs_of_match[];
+static const struct of_device_id pcs_of_match[];
 
 static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 {
@@ -2000,7 +2000,7 @@ static const struct pcs_soc_data pinconf_single = {
 	.flags = PCS_FEAT_PINCONF,
 };
 
-static struct of_device_id pcs_of_match[] = {
+static const struct of_device_id pcs_of_match[] = {
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 9e5ec00..8442202 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1531,7 +1531,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
 	return 0;
 }
 
-static struct of_device_id st_pctl_of_match[] = {
+static const struct of_device_id st_pctl_of_match[] = {
 	{ .compatible = "st,stih415-sbc-pinctrl", .data = &stih415_sbc_data },
 	{ .compatible = "st,stih415-rear-pinctrl", .data = &stih415_rear_data },
 	{ .compatible = "st,stih415-left-pinctrl", .data = &stih415_left_data },
diff --git a/drivers/pinctrl/pinctrl-tz1090-pdc.c b/drivers/pinctrl/pinctrl-tz1090-pdc.c
index fab6aaf..8a8911b 100644
--- a/drivers/pinctrl/pinctrl-tz1090-pdc.c
+++ b/drivers/pinctrl/pinctrl-tz1090-pdc.c
@@ -969,7 +969,7 @@ static int tz1090_pdc_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tz1090_pdc_pinctrl_of_match[] = {
+static const struct of_device_id tz1090_pdc_pinctrl_of_match[] = {
 	{ .compatible = "img,tz1090-pdc-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-tz1090.c b/drivers/pinctrl/pinctrl-tz1090.c
index 8bd73075..fc5594a5 100644
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
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 24c5d88..37aa2a8 100644
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
index 45a351a..6367661 100644
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
index 4bd2347..2bb07b3 100644
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
index 02174fa..9596b0a3 100644
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
index 18038f0..022863a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -922,7 +922,7 @@ static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
 				  &sun6i_a31_pinctrl_data);
 }
 
-static struct of_device_id sun6i_a31_pinctrl_match[] = {
+static const struct of_device_id sun6i_a31_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
index 9b5a91f..d3725dc 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
@@ -794,7 +794,7 @@ static int sun6i_a31s_pinctrl_probe(struct platform_device *pdev)
 				  &sun6i_a31s_pinctrl_data);
 }
 
-static struct of_device_id sun6i_a31s_pinctrl_match[] = {
+static const struct of_device_id sun6i_a31s_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31s-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index 6af6cc8..cf1ce0c 100644
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
index 327e03f..0562876 100644
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
index 62695c9..55083d2 100644
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
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index adb2942..1b580ba 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -729,7 +729,7 @@ static int sun9i_a80_pinctrl_probe(struct platform_device *pdev)
 				  &sun9i_a80_pinctrl_data);
 }
 
-static struct of_device_id sun9i_a80_pinctrl_match[] = {
+static const struct of_device_id sun9i_a80_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/vt8500/pinctrl-vt8500.c b/drivers/pinctrl/vt8500/pinctrl-vt8500.c
index cf8bbc9..ca946b3 100644
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
index 3f9c32d..626fc7e 100644
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
index 4e80f98..8953aba 100644
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
index 47b52a7..c79053d 100644
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
index 8bbb38c..f232b16 100644
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
