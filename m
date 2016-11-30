From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 14:57:32 +0900
Subject: [PATCH 04/12] power_supply: qcom_smbb: Replace the deprecated extcon
 API
In-Reply-To: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480485460-2663-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/power/supply/qcom_smbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index bb91a1c339bc..7b1991265b03 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -378,7 +378,7 @@ static irqreturn_t smbb_usb_valid_handler(int irq, void *_data)
 	struct smbb_charger *chg = _data;
 
 	smbb_set_line_flag(chg, irq, STATUS_USBIN_VALID);
-	extcon_set_cable_state_(chg->edev, EXTCON_USB,
+	extcon_set_state_sync(chg->edev, EXTCON_USB,
 				chg->status & STATUS_USBIN_VALID);
 	power_supply_changed(chg->usb_psy);
 
-- 
1.9.1
