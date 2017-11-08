From: colin.king@canonical.com (Colin King)
Date: Wed,  8 Nov 2017 12:47:55 +0000
Subject: [PATCH] usb: gadget: udc-xilinx: remove redundant pointer udc
Message-ID: <20171108124755.24947-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Pointer udc is assigned but never read, hence it is redundant and
can be removed. Cleans up clang warning:

drivers/usb/gadget/udc/udc-xilinx.c:974:2: warning: Value stored
to 'udc' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 7da2b9ce8cb3..6407e433bc78 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -963,10 +963,8 @@ static struct usb_request *xudc_ep_alloc_request(struct usb_ep *_ep,
 						 gfp_t gfp_flags)
 {
 	struct xusb_ep *ep = to_xusb_ep(_ep);
-	struct xusb_udc *udc;
 	struct xusb_req *req;
 
-	udc = ep->udc;
 	req = kzalloc(sizeof(*req), gfp_flags);
 	if (!req)
 		return NULL;
-- 
2.14.1
