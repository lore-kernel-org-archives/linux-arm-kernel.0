From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 19:23:33 +0100
Subject: [PATCH 3/3] USB: host: ohci_at91: usb_hcd_at91_probe(),
 remove useless stack initialisation
In-Reply-To: <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150117160304.GA21820@gradator.net>
 <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421519013-22123-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct usb_hcd *hcd = NULL;
...
hcd = usb_create_hcd(driver, dev, "at91");

This patch remove *hcd useless initialisation to NULL;

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ohci-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ca53f8a..10c9d76 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -146,7 +146,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	struct at91_usbh_data *board;
 	struct ohci_hcd *ohci;
 	int retval;
-	struct usb_hcd *hcd = NULL;
+	struct usb_hcd *hcd;
 	struct ohci_at91 *ohci_at91;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-- 
2.1.4
