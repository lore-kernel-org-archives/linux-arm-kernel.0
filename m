From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:20 +0200
Subject: [PATCH 03/11] usb/ohci-omap: remove unused variable
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c2e935a7d "USB: move transceiver from ehci_hcd and ohci_hcd to
hcd and rename it as phy" removed the last use of the "ohci" variable
in the usb_hcd_omap_remove function, but left the variable in place
unused.

Without this patch, building omap1_defconfig results in:

In file included from drivers/usb/host/ohci-hcd.c:1013:0:
drivers/usb/host/ohci-omap.c: In function 'usb_hcd_omap_remove':
drivers/usb/host/ohci-omap.c:406:19: warning: unused variable 'ohci' [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Zhao <richard.zhao@freescale.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-omap.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index e7d75d2..f8b2d91 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -403,8 +403,6 @@ err0:
 static inline void
 usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 {
-	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
-
 	usb_remove_hcd(hcd);
 	if (!IS_ERR_OR_NULL(hcd->phy)) {
 		(void) otg_set_host(hcd->phy->otg, 0);
-- 
1.7.10
