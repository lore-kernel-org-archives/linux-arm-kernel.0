From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 May 2012 10:49:41 +0200
Subject: [PATCH] USB: ohci-at91: use resource_size() for memory/io resource
 length
Message-ID: <1336553381-31131-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 13ebeca..da9ddd1 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -129,7 +129,7 @@ static int __devinit usb_hcd_at91_probe(const struct hc_driver *driver,
 	if (!hcd)
 		return -ENOMEM;
 	hcd->rsrc_start = pdev->resource[0].start;
-	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+	hcd->rsrc_len = resource_size(&pdev->resource[0]);
 
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
 		pr_debug("request_mem_region failed\n");
-- 
1.7.10
