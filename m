From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 9 May 2018 19:29:16 +0800
Subject: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for SuperSpeed
 or higher speeds
Message-ID: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3CV version 2.1.80 (March 26, 2018) requires all devices
( gen1, gen2, single lane, dual lane) to return the value of 0x0320
in the bcdUSB field

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 63a7cb8..f242c2b 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1601,7 +1601,7 @@ static int fill_ext_prop(struct usb_configuration *c, int interface, u8 *buf)
 				cdev->gadget->ep0->maxpacket;
 			if (gadget_is_superspeed(gadget)) {
 				if (gadget->speed >= USB_SPEED_SUPER) {
-					cdev->desc.bcdUSB = cpu_to_le16(0x0310);
+					cdev->desc.bcdUSB = cpu_to_le16(0x0320);
 					cdev->desc.bMaxPacketSize0 = 9;
 				} else {
 					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
-- 
1.9.1
