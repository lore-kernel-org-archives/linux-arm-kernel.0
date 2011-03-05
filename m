From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:18:49 +0800
Subject: [PATCH 1/3] video: mxsfb: smarten the code a little bit
In-Reply-To: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299341931-30241-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fix indentation issue in register definitions
* Remove empty pair of {} in mxsfb_devtype[]
* Add a message for a successful mxsfb_probe, which seems useful
  to tell that mxsfb driver is built in and probed successfully

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/video/mxsfb.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index a3b1179..8a57f8b 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -52,11 +52,11 @@
 #define LCDC_CTRL			0x00
 #define LCDC_CTRL1			0x10
 #define LCDC_V4_CTRL2			0x20
-#define LCDC_V3_TRANSFER_COUNT	0x20
-#define LCDC_V4_TRANSFER_COUNT	0x30
-#define LCDC_V4_CUR_BUF		0x40
+#define LCDC_V3_TRANSFER_COUNT		0x20
+#define LCDC_V4_TRANSFER_COUNT		0x30
+#define LCDC_V4_CUR_BUF			0x40
 #define LCDC_V4_NEXT_BUF		0x50
-#define LCDC_V3_CUR_BUF		0x30
+#define LCDC_V3_CUR_BUF			0x30
 #define LCDC_V3_NEXT_BUF		0x40
 #define LCDC_TIMING			0x60
 #define LCDC_VDCTRL0			0x70
@@ -71,8 +71,8 @@
 #define LCDC_DVICTRL4			0x100
 #define LCDC_V4_DATA			0x180
 #define LCDC_V3_DATA			0x1b0
-#define LCDC_V4_DEBUG0		0x1d0
-#define LCDC_V3_DEBUG0		0x1f0
+#define LCDC_V4_DEBUG0			0x1d0
+#define LCDC_V3_DEBUG0			0x1f0
 
 #define CTRL_SFTRST			(1 << 31)
 #define CTRL_CLKGATE			(1 << 30)
@@ -832,6 +832,8 @@ static int __devinit mxsfb_probe(struct platform_device *pdev)
 		mxsfb_enable_controller(fb_info);
 	}
 
+	dev_info(&pdev->dev, "initialized\n");
+
 	return 0;
 
 error_register:
@@ -882,7 +884,6 @@ static struct platform_device_id mxsfb_devtype[] = {
 	}, {
 		.name = "imx28-fb",
 		.driver_data = MXSFB_V4,
-	}, {
 	},
 };
 MODULE_DEVICE_TABLE(platform, mxsfb_devtype);
-- 
1.7.1
