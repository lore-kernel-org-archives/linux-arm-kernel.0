From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 14:39:03 +0100
Subject: [PATCHv7 5/6] USB: host: ohci-at91: usb_hcd_at91_probe(),
 remove useless stack initialisation
In-Reply-To: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421761144-11767-6-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct usb_hcd *hcd = NULL;
...
hcd = usb_create_hcd(driver, dev, "at91");

This patch remove *hcd useless initialisation

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index c810917..970a776 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -142,7 +142,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	struct at91_usbh_data *board;
 	struct ohci_hcd *ohci;
 	int retval;
-	struct usb_hcd *hcd = NULL;
+	struct usb_hcd *hcd;
 	struct ohci_at91_priv *ohci_at91;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-- 
2.1.4
