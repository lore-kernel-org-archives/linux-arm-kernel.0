From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:26 +0200
Subject: [PATCH 5/9] usb: musb: print error message with dev_err() instead of
 dev_dbg()
In-Reply-To: <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 8623112..f867b44 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1878,7 +1878,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 * Fail when the board needs a feature that's not enabled.
 	 */
 	if (!plat) {
-		dev_dbg(dev, "no platform_data?\n");
+		dev_err(dev, "no platform_data?\n");
 		status = -ENODEV;
 		goto fail0;
 	}
-- 
1.7.10.4
