From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 14:57:40 +0900
Subject: [PATCH 12/12] usb: renesas_usbhs: Replace the deprecated extcon API
In-Reply-To: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/usb/renesas_usbhs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 012a37aa3e0d..623c51300393 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -389,7 +389,7 @@ static void usbhsc_hotplug(struct usbhs_priv *priv)
 
 	if (enable && !mod) {
 		if (priv->edev) {
-			cable = extcon_get_cable_state_(priv->edev, EXTCON_USB_HOST);
+			cable = extcon_get_state(priv->edev, EXTCON_USB_HOST);
 			if ((cable > 0 && id != USBHS_HOST) ||
 			    (!cable && id != USBHS_GADGET)) {
 				dev_info(&pdev->dev,
-- 
1.9.1
