From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:09:32 +0000
Subject: [PATCH 2/5] USB: sa1111: get rid of nasty printk(KERN_DEBUG "%s:
 ...", __FILE__)
In-Reply-To: <20120203200406.GI14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPRs-00048U-QU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_dbg() instead, it's more friendly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 50ebeb3..e797f18 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -48,8 +48,7 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
 	unsigned int usb_rst = 0;
 	int ret;
 
-	printk(KERN_DEBUG "%s: starting SA-1111 OHCI USB Controller\n",
-	       __FILE__);
+	dev_dbg(&dev->dev, "starting SA-1111 OHCI USB Controller\n");
 
 	if (machine_is_xp860() ||
 	    machine_has_neponset() ||
@@ -81,8 +80,7 @@ static void sa1111_stop_hc(struct sa1111_dev *dev)
 {
 	unsigned int usb_rst;
 
-	printk(KERN_DEBUG "%s: stopping SA-1111 OHCI USB Controller\n",
-	       __FILE__);
+	dev_dbg(&dev->dev, "stopping SA-1111 OHCI USB Controller\n");
 
 	/*
 	 * Put the USB host controller into reset.
-- 
1.7.4.4
