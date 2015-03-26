From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 26 Mar 2015 23:00:31 +0100
Subject: [PATCH v2] pinctrl: make of_device_ids const
Message-ID: <1427407231-2253-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. This allows to
mark all struct of_device_id below drivers/pinctrl const, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I already sent a similar patch earlier (Message-Id:
1410380437-17960-1-git-send-email-u.kleine-koenig at pengutronix.de) but
it conflicted with another similar patch.

This is rebased and adds several more (new) instances to fix.

Best regards
Uwe

 drivers/pinctrl/freescale/pinctrl-vf610.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c  | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c   | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c    | 2 +-
 drivers/pinctrl/mvebu/pinctrl-orion.c       | 2 +-
 drivers/pinctrl/pinctrl-as3722.c            | 2 +-
 drivers/pinctrl/pinctrl-at91.c              | 4 ++--
 drivers/pinctrl/pinctrl-bcm2835.c           | 2 +-
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
 30 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index fc86276892fd..37a037543d29 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -302,7 +302,7 @@ static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
 	.flags = SHARE_MUX_CONF_REG,
 };
 
-static struct of_device_id vf610_pinctrl_of_match[] = {
+static const struct of_device_id vf610_pinctrl_of_match[] = {
 	{ .compatible = "fsl,vf610-iomuxc", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index c4f51d0cd2cc..42f930f70de3 100644
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
index cd7c8f51f7d9..ca1e7571fedb 100644
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
index 7302f66f4f19..83bbcc72be1f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -389,7 +389,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 
 static struct mvebu_pinctrl_soc_info armada_38x_pinctrl_info;
 
-static struct of_device_id armada_38x_pinctrl_of_match[] = {
+static const struct of_device_id armada_38x_pinctrl_of_match[] = {
 	{
 		.compatible = "marvell,mv88f6810-pinctrl",
 		.data       = (void *) V_88F6810,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index fc3376147c18..7daedc181e99 100644
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
index dbc673cf7131..0f07dc554a1d 100644
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
index 3a632efb56bb..3b7122d826e4 100644
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
index 169b1bfa00c8..db0571ffbe99 100644
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
index a4814066ea08..e5585f5d3401 100644
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
@@ -1694,7 +1694,7 @@ static struct gpio_chip at91_gpio_template = {
 	.ngpio			= MAX_NB_GPIO_PER_BANK,
 };
 
-static struct of_device_id at91_gpio_of_match[] = {
+static const struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 9aa8a3f10b10..4d08b850478e 100644
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
diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index 26461e30f0ae..2631df0504bd 100644
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
index 69e84427f913..13b45f297727 100644
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
index 9e5ec00084bb..84422028ba01 100644
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
index fab6aafa6a9f..8a8911bb883a 100644
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
index 8bd73075f9dd..fc5594a530c2 100644
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
index 3c68a8e5e0dd..7376a97b5e65 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -1020,7 +1020,7 @@ static int sun4i_a10_pinctrl_probe(struct platform_device *pdev)
 				  &sun4i_a10_pinctrl_data);
 }
 
-static struct of_device_id sun4i_a10_pinctrl_match[] = {
+static const struct of_device_id sun4i_a10_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
 	{}
 };
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
index 45a351affa59..63676617bc59 100644
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
index 4bd23471412c..2bb07b38834f 100644
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
index 02174fa57997..9596b0a3df6b 100644
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
index 18038f0d6b52..022863ab0c58 100644
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
index 9b5a91f610c7..d3725dcd6979 100644
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
index 6af6cc8547b0..cf1ce0c02600 100644
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
index 327e03ff7c4d..056287635873 100644
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
index 62695c9a92c2..55083d278bb1 100644
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
index adb29422efc9..1b580ba76453 100644
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
index cf8bbc946ff7..ca946b3dbdb4 100644
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
index 3f9c32dcb3d0..626fc7ec0174 100644
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
index 4e80f98c2ba7..8953aba8bfc2 100644
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
index 47b52a7cacac..c79053d430db 100644
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
index 8bbb38c931f6..f232b163c735 100644
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
2.1.4
