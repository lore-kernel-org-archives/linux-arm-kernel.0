From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 23 Oct 2013 16:35:09 +0800
Subject: [PATCH 3/3] usb: chipidea: imx: set CI_HDRC_IMX28_WRITE_FIX for imx28
In-Reply-To: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
References: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382517309-6730-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to imx28 needs ARM swp instruction for writing, we set
CI_HDRC_IMX28_WRITE_FIX for imx28.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 4045c76..5b1cbaa 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -128,6 +128,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		data->supports_runtime_pm = true;
 	}
 
+	if (of_device_is_compatible(np, "fsl,imx28-usb"))
+		pdata.flags |= CI_HDRC_IMX28_WRITE_FIX;
+
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	if (!pdev->dev.coherent_dma_mask)
@@ -309,6 +312,7 @@ static const struct dev_pm_ops ci_hdrc_imx_pm_ops = {
 };
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx27-usb", },
+	{ .compatible = "fsl,imx28-usb", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
-- 
1.7.1
