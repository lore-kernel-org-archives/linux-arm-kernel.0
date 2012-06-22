From: steveb@workware.net.au (Steve Bennett)
Date: Fri, 22 Jun 2012 14:14:12 +1000
Subject: [PATCH] usb: gadget: pxa25x_udc: compile fix
Message-ID: <1340338452-885-1-git-send-email-steveb@workware.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steve Bennett <steveb@workware.net.au>
---
 drivers/usb/gadget/pxa25x_udc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.h b/drivers/usb/gadget/pxa25x_udc.h
index 861f4df..2eca1e7 100644
--- a/drivers/usb/gadget/pxa25x_udc.h
+++ b/drivers/usb/gadget/pxa25x_udc.h
@@ -225,7 +225,7 @@ dump_state(struct pxa25x_udc *dev)
 		dev->stats.read.bytes, dev->stats.read.ops);
 
 	for (i = 1; i < PXA_UDC_NUM_ENDPOINTS; i++) {
-		if (dev->ep [i].desc == NULL)
+		if (dev->ep[i].ep.desc == NULL)
 			continue;
 		DMSG ("udccs%d = %02x\n", i, *dev->ep->reg_udccs);
 	}
-- 
1.7.10
