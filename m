From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:56 +0200
Subject: [RFC/PATCH 18/32] usb: gadget: mv_u3d_core: fix a compile warning
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-19-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile warning:

mv_u3d_core.c:1766:12: warning: 'mv_u3d_remove' \
	defined but not used [-Wunused-function]

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/mv_u3d_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index 565addc..734ade1 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -2072,7 +2072,7 @@ static void mv_u3d_shutdown(struct platform_device *dev)
 
 static struct platform_driver mv_u3d_driver = {
 	.probe		= mv_u3d_probe,
-	.remove		= __exit_p(mv_u3d_remove),
+	.remove		= mv_u3d_remove,
 	.shutdown	= mv_u3d_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
-- 
1.8.1.rc1.5.g7e0651a
