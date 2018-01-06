From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:51 +0100
Subject: [PATCH v2 3/5] pinctrl: imx: constify struct imx_pinctrl_soc_info
In-Reply-To: <20180106142553.15322-1-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
Message-ID: <20180106142553.15322-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that imx_pinctrl_probe accepts const struct imx_pinctrl_soc_info
we can constify all declarations of struct imx_pinctrl_soc_info.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx25.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx35.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx50.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx51.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx53.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx6dl.c  | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx6q.c   | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sl.c  | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sx.c  | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 2 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx25.c b/drivers/pinctrl/freescale/pinctrl-imx25.c
index d7367fabe712..db6d9d1382f9 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx25.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx25.c
@@ -309,7 +309,7 @@ static const struct pinctrl_pin_desc imx25_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX25_PAD_BOOT_MODE1),
 };
 
-static struct imx_pinctrl_soc_info imx25_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx25_pinctrl_info = {
 	.pins = imx25_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx25_pinctrl_pads),
 };
diff --git a/drivers/pinctrl/freescale/pinctrl-imx35.c b/drivers/pinctrl/freescale/pinctrl-imx35.c
index 6315ba6af431..6927946ae4b5 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx35.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx35.c
@@ -999,7 +999,7 @@ static const struct pinctrl_pin_desc imx35_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX35_PAD_TEST_MODE),
 };
 
-static struct imx_pinctrl_soc_info imx35_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx35_pinctrl_info = {
 	.pins = imx35_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx35_pinctrl_pads),
 };
diff --git a/drivers/pinctrl/freescale/pinctrl-imx50.c b/drivers/pinctrl/freescale/pinctrl-imx50.c
index 8e3a17df5c5d..eb349b97290f 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx50.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx50.c
@@ -385,7 +385,7 @@ static const struct pinctrl_pin_desc imx50_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX50_PAD_EIM_CRE),
 };
 
-static struct imx_pinctrl_soc_info imx50_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx50_pinctrl_info = {
 	.pins = imx50_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx50_pinctrl_pads),
 	.gpr_compatible = "fsl,imx50-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx51.c b/drivers/pinctrl/freescale/pinctrl-imx51.c
index eeac64ba2709..49acd991b5fb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx51.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx51.c
@@ -762,7 +762,7 @@ static const struct pinctrl_pin_desc imx51_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX51_PAD_CSI1_MCLK),
 };
 
-static struct imx_pinctrl_soc_info imx51_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx51_pinctrl_info = {
 	.pins = imx51_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx51_pinctrl_pads),
 };
diff --git a/drivers/pinctrl/freescale/pinctrl-imx53.c b/drivers/pinctrl/freescale/pinctrl-imx53.c
index 46a9572f3473..6dd0c60eaea4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx53.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx53.c
@@ -448,7 +448,7 @@ static const struct pinctrl_pin_desc imx53_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX53_PAD_GPIO_18),
 };
 
-static struct imx_pinctrl_soc_info imx53_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx53_pinctrl_info = {
 	.pins = imx53_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx53_pinctrl_pads),
 	.gpr_compatible = "fsl,imx53-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6dl.c b/drivers/pinctrl/freescale/pinctrl-imx6dl.c
index 3f25ca5867cc..91b85fc01de8 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6dl.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6dl.c
@@ -457,7 +457,7 @@ static const struct pinctrl_pin_desc imx6dl_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6DL_PAD_SD4_DAT7),
 };
 
-static struct imx_pinctrl_soc_info imx6dl_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx6dl_pinctrl_info = {
 	.pins = imx6dl_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx6dl_pinctrl_pads),
 	.gpr_compatible = "fsl,imx6q-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6q.c b/drivers/pinctrl/freescale/pinctrl-imx6q.c
index d61651c40458..5f653d69d0f5 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6q.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6q.c
@@ -460,7 +460,7 @@ static const struct pinctrl_pin_desc imx6q_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6Q_PAD_SD2_DAT3),
 };
 
-static struct imx_pinctrl_soc_info imx6q_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx6q_pinctrl_info = {
 	.pins = imx6q_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx6q_pinctrl_pads),
 	.gpr_compatible = "fsl,imx6q-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6sl.c b/drivers/pinctrl/freescale/pinctrl-imx6sl.c
index d023f6b00623..1167dc273c04 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6sl.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6sl.c
@@ -363,7 +363,7 @@ static const struct pinctrl_pin_desc imx6sl_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6SL_PAD_WDOG_B),
 };
 
-static struct imx_pinctrl_soc_info imx6sl_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx6sl_pinctrl_info = {
 	.pins = imx6sl_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx6sl_pinctrl_pads),
 	.gpr_compatible = "fsl,imx6sl-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6sx.c b/drivers/pinctrl/freescale/pinctrl-imx6sx.c
index 898b781701e6..15ea56c75f68 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6sx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6sx.c
@@ -367,7 +367,7 @@ static const struct pinctrl_pin_desc imx6sx_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6SX_PAD_USB_H_STROBE),
 };
 
-static struct imx_pinctrl_soc_info imx6sx_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx6sx_pinctrl_info = {
 	.pins = imx6sx_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx6sx_pinctrl_pads),
 	.gpr_compatible = "fsl,imx6sx-iomuxc-gpr",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
index 9161c984f57b..0406d8b39e6a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -324,7 +324,7 @@ static int imx7ulp_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct imx_pinctrl_soc_info imx7ulp_pinctrl_info = {
+static const struct imx_pinctrl_soc_info imx7ulp_pinctrl_info = {
 	.pins = imx7ulp_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx7ulp_pinctrl_pads),
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index 42745c690be3..c078f859ae15 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -318,7 +318,7 @@ static int vf610_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
+static const struct imx_pinctrl_soc_info vf610_pinctrl_info = {
 	.pins = vf610_pinctrl_pads,
 	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
 	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
-- 
2.15.1
