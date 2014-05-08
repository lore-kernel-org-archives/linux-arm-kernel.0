From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:19 +0200
Subject: [PATCH 6/8] usb: xhci: avoid warning for !PM_SLEEP
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Message-ID: <1399557141-1346645-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we build a kernel with PM_SUSPEND set and no PM_SLEEP,
we get a build warning in the xhci-plat driver about unused
functions.

To fix this, use "#ifdef CONFIG_PM_SLEEP", like we do in most
other drivers nowadays.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>
---
 drivers/usb/host/xhci-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 151901c..3473296 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -202,7 +202,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int xhci_plat_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
-- 
1.8.3.2
