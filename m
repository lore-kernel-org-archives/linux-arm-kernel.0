From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 18 Sep 2015 20:22:26 +0200
Subject: [PATCH 4/4] usb: host: uhci-platform: Fix module autoload for OF
 platform driver
Message-ID: <20150918182226.GA31658@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/usb/host/uhci-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 3a3e3ee..32a6f3d 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -140,6 +140,7 @@ static const struct of_device_id platform_uhci_ids[] = {
 	{ .compatible = "platform-uhci", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, platform_uhci_ids);
 
 static struct platform_driver uhci_platform_driver = {
 	.probe		= uhci_hcd_platform_probe,
-- 
2.4.6
