From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 25 Jan 2018 15:37:29 +0800
Subject: [PATCH 2/2] nvmem: imx-ocotp: remove unused dead code
In-Reply-To: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
References: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516865849-26191-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove unused dead code

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index d7ba351..4f61fbd 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -439,7 +439,6 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct ocotp_priv *priv;
@@ -460,7 +459,6 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	of_id = of_match_device(imx_ocotp_dt_ids, dev);
 	priv->params = of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
-- 
2.7.4
