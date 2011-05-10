From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 16:24:23 +0200
Subject: [PATCH] usb/gadget: at91sam9g20 fix end point max packet size
Message-ID: <1305037463-10222-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 9g20 they are the same as the 9261

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/gadget/at91_udc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 9b7cdb1..41dc093 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1767,7 +1767,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
 	}
 
 	/* newer chips have more FIFO memory than rm9200 */
-	if (cpu_is_at91sam9260()) {
+	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {
 		udc->ep[0].maxpacket = 64;
 		udc->ep[3].maxpacket = 64;
 		udc->ep[4].maxpacket = 512;
-- 
1.7.4.1
