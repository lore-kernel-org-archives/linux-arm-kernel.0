From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 14:02:55 +0000
Subject: [PATCH v2 4/9] usb: host: ehci-st: Simplify return statement
In-Reply-To: <cover.1438695318.git.skarajga@visteon.com>
References: <cover.1438695318.git.skarajga@visteon.com>
Message-ID: <29a173be5ace786d064ae14c02324fee42fee06c.1438695318.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/host/ehci-st.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index 7e4bd39..b7c5cfa 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -54,7 +54,6 @@ static int st_ehci_platform_reset(struct usb_hcd *hcd)
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-	int retval;
 	u32 threshold;
 
 	/* Set EHCI packet buffer IN/OUT threshold to 128 bytes */
@@ -62,11 +61,7 @@ static int st_ehci_platform_reset(struct usb_hcd *hcd)
 	writel(threshold, hcd->regs + AHB2STBUS_INSREG01);
 
 	ehci->caps = hcd->regs + pdata->caps_offset;
-	retval = ehci_setup(hcd);
-	if (retval)
-		return retval;
-
-	return 0;
+	return ehci_setup(hcd);
 }
 
 static int st_ehci_platform_power_on(struct platform_device *dev)
-- 
1.9.1
