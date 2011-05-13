From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 13 May 2011 17:03:02 +0200
Subject: [PATCH V2] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <1305042888-19401-1-git-send-email-plagnioj@jcrosoft.com>
References: <1305042888-19401-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1305298982-5789-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 9g20 they are the same as the 9260

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Resent upon Greg's request.
Based on current linux-next.
Applies cleanly on current linus' tree (2.6.39-rc7+)

BTW, can we imagine it going to mainline before .39-final in a "fixes" pull
request to Linus from a at91 tree?

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
1.7.3
