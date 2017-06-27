From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 27 Jun 2017 16:30:30 -0500
Subject: [PATCH] usb: gadget: udc-xilinx: remove useless variable assignment
 in xudc_read_fifo()
Message-ID: <20170627213030.GA5574@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Value assigned to variable bufferspace at line 637 is overwritten
at line 613, before it can be used. This makes such variable
assignment useless.

Addresses-Coverity-ID: 1397677
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index de207a9..7afdf8e 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -634,7 +634,6 @@ static int xudc_read_fifo(struct xusb_ep *ep, struct xusb_req *req)
 		dev_dbg(udc->dev, "read %s, %d bytes%s req %p %d/%d\n",
 			ep->ep_usb.name, count, is_short ? "/S" : "", req,
 			req->usb_req.actual, req->usb_req.length);
-		bufferspace -= count;
 		/* Completion */
 		if ((req->usb_req.actual == req->usb_req.length) || is_short) {
 			if (udc->dma_enabled && req->usb_req.length)
-- 
2.5.0
