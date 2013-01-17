From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 13:30:19 +0200
Subject: [PATCH v7 10/22] mfd: omap_usb_host: Avoid missing platform data
 checks in suspend/resume
In-Reply-To: <1358422231-24736-1-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
Message-ID: <1358422231-24736-11-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the unnecessary missing platform data checks
in runtime_suspend/resume. We are already checking for missing
platform data in probe.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index d6e6b8c..061366d 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -277,11 +277,6 @@ static int usbhs_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	omap_tll_enable();
 	spin_lock_irqsave(&omap->lock, flags);
 
@@ -309,11 +304,6 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	dev_dbg(dev, "usbhs_runtime_suspend\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&omap->lock, flags);
 
 	if (is_ehci_tll_mode(pdata->port_mode[0]))
-- 
1.7.4.1
