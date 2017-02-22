From: colin.king@canonical.com (Colin King)
Date: Wed, 22 Feb 2017 23:30:52 +0000
Subject: [PATCH] phy: rockchip-inno-usb2: fix spelling mistake: "connecetd" ->
 "connected"
Message-ID: <20170222233052.8016-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_dbg message, also rejoin
lines to clean up checkpatch warning

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 4ea95c2..761a921 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -554,8 +554,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			case USB_CHG_STATE_DETECTED:
 				switch (rphy->chg_type) {
 				case POWER_SUPPLY_TYPE_USB:
-					dev_dbg(&rport->phy->dev,
-						"sdp cable is connecetd\n");
+					dev_dbg(&rport->phy->dev, "sdp cable is connected\n");
 					rockchip_usb2phy_power_on(rport->phy);
 					rport->state = OTG_STATE_B_PERIPHERAL;
 					notify_charger = true;
@@ -563,16 +562,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 					cable = EXTCON_CHG_USB_SDP;
 					break;
 				case POWER_SUPPLY_TYPE_USB_DCP:
-					dev_dbg(&rport->phy->dev,
-						"dcp cable is connecetd\n");
+					dev_dbg(&rport->phy->dev, "dcp cable is connected\n");
 					rockchip_usb2phy_power_off(rport->phy);
 					notify_charger = true;
 					sch_work = true;
 					cable = EXTCON_CHG_USB_DCP;
 					break;
 				case POWER_SUPPLY_TYPE_USB_CDP:
-					dev_dbg(&rport->phy->dev,
-						"cdp cable is connecetd\n");
+					dev_dbg(&rport->phy->dev, "cdp cable is connected\n");
 					rockchip_usb2phy_power_on(rport->phy);
 					rport->state = OTG_STATE_B_PERIPHERAL;
 					notify_charger = true;
-- 
2.10.2
