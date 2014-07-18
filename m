From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:29 +0200
Subject: [PATCH 8/9] usb: phy: am335x: call
 usb_gen_phy_init()/usb_gen_phy_shutdown() in am335x_init()/am335x_shutdown()
In-Reply-To: <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to use the musb driver with HW that
requires external regulators or clocks.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/phy/phy-am335x.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index 6522fa7..de25674 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -22,6 +22,7 @@ static int am335x_init(struct usb_phy *phy)
 {
 	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
 
+	usb_gen_phy_init(phy);
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, true);
 	return 0;
 }
@@ -31,6 +32,7 @@ static void am335x_shutdown(struct usb_phy *phy)
 	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
 
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, false);
+	usb_gen_phy_shutdown(phy);
 }
 
 static int am335x_phy_probe(struct platform_device *pdev)
-- 
1.7.10.4
