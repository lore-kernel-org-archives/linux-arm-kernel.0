From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 27 May 2015 18:13:30 +0800
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: add imx6sx support
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1432721611-31214-6-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <b29396@freescale.com>

The imx6sx usdhc is derived from imx6sl, the difference is minor.
imx6sx have the errata ESDHC_FLAG_ERR004536 fixed.
So introduce a new compatible string for imx6sx to distinguish them.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a3b82d1..bcb5673 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -148,6 +148,11 @@ static struct esdhc_soc_data usdhc_imx6sl_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
 };
 
+static struct esdhc_soc_data usdhc_imx6sx_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -188,6 +193,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
+	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
 	{ /* sentinel */ }
-- 
1.9.1
