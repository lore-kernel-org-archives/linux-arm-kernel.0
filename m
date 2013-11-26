From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 26 Nov 2013 19:36:50 +0400
Subject: [PATCH v2 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
References: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
Message-ID: <1385480210-9349-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds i.MX51 as the next user of the usbmisc driver.
Functionality is similar to i.MX53, so at this stage simply
reuse existing i.MX53 calls.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 4381c5a6..cd061ab 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -204,6 +204,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
 		.data = &imx27_usbmisc_ops,
 	},
 	{
+		.compatible = "fsl,imx51-usbmisc",
+		.data = &imx53_usbmisc_ops,
+	},
+	{
 		.compatible = "fsl,imx53-usbmisc",
 		.data = &imx53_usbmisc_ops,
 	},
-- 
1.8.3.2
