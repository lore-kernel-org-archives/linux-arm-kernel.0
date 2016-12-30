From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 30 Dec 2016 13:11:28 +0900
Subject: [PATCH v2 1/2] phy: rcar-gen3-usb2: Replace the deprecated extcon API
In-Reply-To: <1483071089-8362-1-git-send-email-cw00.choi@samsung.com>
References: <1483071089-8362-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161230041136epcas5p45074607ce44561b57561bfb20a8c3bc4@epcas5p4.samsung.com>
Message-ID: <1483071089-8362-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/phy-rcar-gen3-usb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
index c63da1b955c1..54a83675f0a8 100644
--- a/drivers/phy/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/phy-rcar-gen3-usb2.c
@@ -94,11 +94,11 @@ static void rcar_gen3_phy_usb2_work(struct work_struct *work)
 						 work);
 
 	if (ch->extcon_host) {
-		extcon_set_cable_state_(ch->extcon, EXTCON_USB_HOST, true);
-		extcon_set_cable_state_(ch->extcon, EXTCON_USB, false);
+		extcon_set_state_sync(ch->extcon, EXTCON_USB_HOST, true);
+		extcon_set_state_sync(ch->extcon, EXTCON_USB, false);
 	} else {
-		extcon_set_cable_state_(ch->extcon, EXTCON_USB_HOST, false);
-		extcon_set_cable_state_(ch->extcon, EXTCON_USB, true);
+		extcon_set_state_sync(ch->extcon, EXTCON_USB_HOST, false);
+		extcon_set_state_sync(ch->extcon, EXTCON_USB, true);
 	}
 }
 
-- 
1.9.1
