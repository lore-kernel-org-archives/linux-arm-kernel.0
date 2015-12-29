From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 29 Dec 2015 16:41:08 +0000
Subject: [PATCH 1/2] usb: chipidea: add CI_HDRC_TURN_VBUS_EARLY_ON for imx23
Message-ID: <1451407269-14905-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now the imx23 uses the imx27 platform flag. But the
imx23 needs the flag CI_HDRC_TURN_VBUS_EARLY_ON, too. So
fix this by adding a separate platform flag.

Suggested-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f14f4ab..b4605dd 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -28,6 +28,11 @@ struct ci_hdrc_imx_platform_flag {
 	bool runtime_pm;
 };
 
+static const struct ci_hdrc_imx_platform_flag imx23_usb_data = {
+	.flags = CI_HDRC_TURN_VBUS_EARLY_ON |
+		CI_HDRC_DISABLE_STREAMING,
+};
+
 static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
 		CI_HDRC_DISABLE_STREAMING,
 };
@@ -66,6 +71,7 @@ static const struct ci_hdrc_imx_platform_flag imx7d_usb_data = {
 };
 
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
 	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
 	{ .compatible = "fsl,imx6q-usb", .data = &imx6q_usb_data},
-- 
1.7.9.5
