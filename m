From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 24 Apr 2018 10:52:46 +0800
Subject: [PATCH 1/5] usb: mtu3: avoid TX data length truncated in SS/SSP mode
Message-ID: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable of 'count' is declared as u8, this will cause an issue
due to value truncated when works in SS or SSP mode and data length
is greater than 255, so change it as u32.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index ebdcf7a..d67b540 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -546,7 +546,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
 	struct usb_request *req;
 	u32 csr;
 	u8 *src;
-	u8 count;
+	u32 count;
 	u32 maxp;
 
 	dev_dbg(mtu->dev, "%s\n", __func__);
-- 
1.9.1
