From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 15 Mar 2016 14:08:28 +0530
Subject: [RFC PATCH 2/4] usb: chipidea: ci_hdrc_imx: Introduce
 CI_HDRC_DUAL_ROLE_NOT_OTG for Vybrid
In-Reply-To: <cover.1458030082.git.maitysanchayan@gmail.com>
References: <cover.1458030082.git.maitysanchayan@gmail.com>
Message-ID: <f2f2348176ba4c52c59f2e440a6492c2931cc86c.1458030082.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Vybrid SoC has a dual role device which can be configured to
act as a host or device through firmware interface, but, it is
not a true OTG controller.

Use the CI_HDRC_DUAL_ROLE_NOT_OTG in the platform flag, introduce
a new platform data structure for Vybrid and match on the compatible
string fsl,vf610-usb instead of the earlier fsl,imx27-usb.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f14f4ab..d9b8a53 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -65,6 +65,10 @@ static const struct ci_hdrc_imx_platform_flag imx7d_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
 };
 
+static const struct ci_hdrc_imx_platform_flag vf610_usb_data = {
+	.flags = CI_HDRC_DUAL_ROLE_NOT_OTG,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
 	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
@@ -73,6 +77,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-usb", .data = &imx6sx_usb_data},
 	{ .compatible = "fsl,imx6ul-usb", .data = &imx6ul_usb_data},
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
+	{ .compatible = "fsl,vf610-usb", .data = &vf610_usb_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
-- 
2.7.3
