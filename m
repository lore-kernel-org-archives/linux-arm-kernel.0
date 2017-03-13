From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 13 Mar 2017 17:21:14 -0400
Subject: [PATCH] [for 4.11]xhci: plat: Register shutdown for xhci_plat
Message-ID: <1489440074-23966-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shutdown should be called for xhci_plat devices especially for
situations where kexec might be used by stopping DMA
transactions.

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 drivers/usb/host/xhci-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index bd02a6c..6ed468f 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -344,6 +344,7 @@ static int xhci_plat_resume(struct device *dev)
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = DEV_PM_OPS,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
