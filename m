From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 14:23:36 +0800
Subject: [Patch v2 07/10] usb: chipidea: imx: Enable runtime pm support for
 imx6 SoC serial
In-Reply-To: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382423019-26184-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, only imx6 SoC serial adds wakeup logic, so only
enable runtime pm for imx6.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 2a14152..d4775b3 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -118,6 +118,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.phy = data->phy;
 
+	if (of_device_is_compatible(np, "fsl,imx6q-usb")) {
+		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
+		data->supports_runtime_pm = true;
+	}
+
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	if (!pdev->dev.coherent_dma_mask)
-- 
1.7.1
