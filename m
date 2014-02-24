From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 24 Feb 2014 10:20:58 +0800
Subject: [PATCH v11 06/15] usb: phy-mxs: change description of usb device speed
In-Reply-To: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
References: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1393208467-6355-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change "high speed" to "HS"
Change "non-high speed" to "FS/LS"

Implementation of notify_suspend and notify_resume will be different
according to mxs_phy_data->flags.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 2411e05..1663a66 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -168,8 +168,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 static int mxs_phy_on_connect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has connected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has connected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
@@ -181,8 +181,8 @@ static int mxs_phy_on_connect(struct usb_phy *phy,
 static int mxs_phy_on_disconnect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has disconnected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has disconnected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
-- 
1.7.8
