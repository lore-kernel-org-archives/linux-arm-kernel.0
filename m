From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:52 +0200
Subject: [PATCH v2 08/13] USB: ohci-at91: trivial return code name change
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <91dcb3feeab529b4d214ccb426da6fed635dd4b5.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/host/ohci-at91.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index a8e0446..7e1abbd 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -552,10 +552,9 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
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
