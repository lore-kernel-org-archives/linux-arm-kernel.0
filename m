From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 07 Jul 2015 16:02:52 +0200
Subject: [PATCH 4/5] staging: emxx_udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436277773-14274-5-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should use usb_ep_set_maxpacket_limit instead of setting
maxpacket value manually.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 4178d96..f50bf5d 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3203,7 +3203,8 @@ static void __init nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
 		ep->ep.name = gp_ep_name[i];
 		ep->ep.ops = &nbu2ss_ep_ops;
 
-		ep->ep.maxpacket = (i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE);
+		usb_ep_set_maxpacket_limit(&ep->ep,
+				(i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE));
 
 		list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 		INIT_LIST_HEAD(&ep->queue);
-- 
1.9.1
