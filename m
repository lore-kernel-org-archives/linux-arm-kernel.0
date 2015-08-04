From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:11:32 +0000
Subject: [PATCH 7/9] usb: host: xhci: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <111974a782999d7133f4fa38d8775241c6c88aee.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/host/xhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 526ebc0..19076fa 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4678,7 +4678,6 @@ int xhci_disable_usb3_lpm_timeout(struct usb_hcd *hcd,
 {
 	struct xhci_hcd	*xhci;
 	u16 mel;
-	int ret;
 
 	xhci = hcd_to_xhci(hcd);
 	if (!xhci || !(xhci->quirks & XHCI_LPM_SUPPORT) ||
@@ -4686,10 +4685,7 @@ int xhci_disable_usb3_lpm_timeout(struct usb_hcd *hcd,
 		return 0;
 
 	mel = calculate_max_exit_latency(udev, state, USB3_LPM_DISABLED);
-	ret = xhci_change_max_exit_latency(xhci, udev, mel);
-	if (ret)
-		return ret;
-	return 0;
+	return xhci_change_max_exit_latency(xhci, udev, mel);
 }
 #else /* CONFIG_PM */
 
-- 
1.9.1
