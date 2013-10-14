From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 14 Oct 2013 18:24:31 +0300
Subject: [PATCH v3 04/13] usb: phy: msm: Remove unnecessarily check for valid
 regulators.
In-Reply-To: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1381764280-28420-5-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Whether regulators are available or not is checked at driver
probe. If they are not available driver will refuse to load,
so no need to check them again.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/usb/phy/phy-msm-usb.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
index 136f063..b77441b 100644
--- a/drivers/usb/phy/phy-msm-usb.c
+++ b/drivers/usb/phy/phy-msm-usb.c
@@ -159,16 +159,6 @@ static int msm_hsusb_ldo_set_mode(struct msm_otg *motg, int on)
 {
 	int ret = 0;
 
-	if (!motg->v1p8 || IS_ERR(motg->v1p8)) {
-		pr_err("%s: HSUSB_1p8 is not initialized\n", __func__);
-		return -ENODEV;
-	}
-
-	if (!motg->v3p3 || IS_ERR(motg->v3p3)) {
-		pr_err("%s: HSUSB_3p3 is not initialized\n", __func__);
-		return -ENODEV;
-	}
-
 	if (on) {
 		ret = regulator_set_optimum_mode(motg->v1p8,
 				USB_PHY_1P8_HPM_LOAD);
-- 
1.7.9.5
