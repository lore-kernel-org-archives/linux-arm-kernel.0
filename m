From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 14 Oct 2013 18:24:38 +0300
Subject: [PATCH v3 11/13] usb: phy: msm: Remove HSUSB prefix from requlator
 names
In-Reply-To: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1381764280-28420-12-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Prefix did not bring any useful information.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/usb/phy/phy-msm-usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
index 0bd3ba5..ca2abe6 100644
--- a/drivers/usb/phy/phy-msm-usb.c
+++ b/drivers/usb/phy/phy-msm-usb.c
@@ -1420,19 +1420,19 @@ static int __init msm_otg_probe(struct platform_device *pdev)
 		return motg->irq;
 	}
 
-	motg->vddcx = devm_regulator_get(motg->phy.dev, "HSUSB_VDDCX");
+	motg->vddcx = devm_regulator_get(motg->phy.dev, "vddcx");
 	if (IS_ERR(motg->vddcx)) {
 		dev_err(motg->phy.dev, "unable to get hsusb vddcx\n");
 		return PTR_ERR(motg->vddcx);
 	}
 
-	motg->v3p3 = devm_regulator_get(motg->phy.dev, "HSUSB_3p3");
+	motg->v3p3 = devm_regulator_get(motg->phy.dev, "v3p3");
 	if (IS_ERR(motg->v3p3)) {
 		dev_err(motg->phy.dev, "unable to get hsusb 3p3\n");
 		return PTR_ERR(motg->v3p3);
 	}
 
-	motg->v1p8 = devm_regulator_get(motg->phy.dev, "HSUSB_1p8");
+	motg->v1p8 = devm_regulator_get(motg->phy.dev, "v1p8");
 	if (IS_ERR(motg->v1p8)) {
 		dev_err(motg->phy.dev, "unable to get hsusb 1p8\n");
 		return PTR_ERR(motg->v1p8);
-- 
1.7.9.5
