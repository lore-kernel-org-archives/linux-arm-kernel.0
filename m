From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 3 Jan 2012 12:12:59 +0530
Subject: [PATCH RFC] MFD: OMAP: USB: Make the runtime functions depend on
 CONFIG_PM_RUNTIME
Message-ID: <1325572979-6090-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the runtime functions are compiled regardless
of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
using SET_RUNTIME_PM_OPS.

Cc : Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
applies on Tony's ehci branch.
Compile tested only.

 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 3f565ef..ef72ebe 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -887,8 +887,8 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
-	.runtime_suspend	= usbhs_runtime_suspend,
-	.runtime_resume		= usbhs_runtime_resume,
+	SET_RUNTIME_PM_OPS(usbhs_runtime_suspend,
+				usbhs_runtime_resume, NULL)
 };
 
 static struct platform_driver usbhs_omap_driver = {
-- 
1.7.1
