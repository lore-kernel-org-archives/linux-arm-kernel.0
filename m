From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Mar 2012 15:27:19 +0200
Subject: [PATCH 08/12] USB: ohci-at91: trivial return code name change
In-Reply-To: <cover.1333026637.git.nicolas.ferre@atmel.com>
References: <cover.1333026637.git.nicolas.ferre@atmel.com>
Message-ID: <50fc3e3c625bfe22ae8fbf07d9e60df15ef41dd2.1333026637.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/host/ohci-at91.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index dd58b555..81c1f3d 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -546,10 +546,9 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	int			gpio;
 	int			ret;
 
-	i = ohci_at91_of_init(pdev);
-
-	if (i)
-		return i;
+	ret = ohci_at91_of_init(pdev);
+	if (ret)
+		return ret;
 
 	pdata = pdev->dev.platform_data;
 
-- 
1.7.9.4
