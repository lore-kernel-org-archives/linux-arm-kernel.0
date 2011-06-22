From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 22 Jun 2011 17:21:43 +0400
Subject: [PATCH] lubbock-usb: fix compilation due to OTG switching to atomic
	notifiers
Message-ID: <1308748903-18642-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
Eric, please fold this patch into your tree, as somewhere between the original
patch I've submitted and the current tree OTG transceiver have switched from
blocking to atomic notifiers.

 drivers/usb/otg/lubbock-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/lubbock-usb.c b/drivers/usb/otg/lubbock-usb.c
index d18c101..d8b8416 100644
--- a/drivers/usb/otg/lubbock-usb.c
+++ b/drivers/usb/otg/lubbock-usb.c
@@ -123,7 +123,7 @@ static int __devinit lubbock_usb_xceiv_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lubbock);
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&lubbock->notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&lubbock->notifier);
 
 	return 0;
 exit:
-- 
1.7.5.3
