From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 14:57:29 +0900
Subject: [PATCH 01/12] phy: rcar-gen3-usb2: Replace the deprecated extcon API
In-Reply-To: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/phy-rcar-gen3-usb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
index bd2430d7339c..7f8081f157f4 100644
--- a/drivers/phy/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/phy-rcar-gen3-usb2.c
@@ -93,11 +93,11 @@ static void rcar_gen3_phy_usb2_work(struct work_struct *work)
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
