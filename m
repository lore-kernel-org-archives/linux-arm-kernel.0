From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:21 -0500
Subject: [V4 PATCH 03/26] usb: gadget: mv_udc: fix the warning of mv_udc_remove
In-Reply-To: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1358762864-9249-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __exit_p() will be NULL if MODULE is no defined.
It will cause the warning. Removing __exit_p to remove
the warning.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index e2fdc8e..910c4b5 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2461,7 +2461,7 @@ static void mv_udc_shutdown(struct platform_device *pdev)
 
 static struct platform_driver udc_driver = {
 	.probe		= mv_udc_probe,
-	.remove		= __exit_p(mv_udc_remove),
+	.remove		= mv_udc_remove,
 	.shutdown	= mv_udc_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
-- 
1.7.4.1
