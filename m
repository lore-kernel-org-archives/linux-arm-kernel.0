From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 14 Oct 2013 18:24:39 +0300
Subject: [PATCH v3 12/13] usb: phy: msm: Properly check core interrupt number
In-Reply-To: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1381764280-28420-13-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

IRQ with number 0 is valid case, so check for negative
numbers instead.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/usb/phy/phy-msm-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
index ca2abe6..f34c8a9 100644
--- a/drivers/usb/phy/phy-msm-usb.c
+++ b/drivers/usb/phy/phy-msm-usb.c
@@ -1415,7 +1415,7 @@ static int __init msm_otg_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "OTG regs = %p\n", motg->regs);
 
 	motg->irq = platform_get_irq(pdev, 0);
-	if (!motg->irq) {
+	if (motg->irq < 0) {
 		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		return motg->irq;
 	}
-- 
1.7.9.5
