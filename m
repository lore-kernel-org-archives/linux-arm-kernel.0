From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 25 Aug 2016 19:39:05 +0200
Subject: [PATCH 13/44] usb: gadget: udc: udc-xilinx: don't print on ENOMEM
In-Reply-To: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
References: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
Message-ID: <20160825173947.26624-14-wsa-dev@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All kmalloc-based functions print enough information on failures.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index f8bf290f189444..588e2531b8b81e 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -973,10 +973,8 @@ static struct usb_request *xudc_ep_alloc_request(struct usb_ep *_ep,
 
 	udc = ep->udc;
 	req = kzalloc(sizeof(*req), gfp_flags);
-	if (!req) {
-		dev_err(udc->dev, "%s:not enough memory", __func__);
+	if (!req)
 		return NULL;
-	}
 
 	req->ep = ep;
 	INIT_LIST_HEAD(&req->queue);
-- 
2.9.3
