From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Tue, 28 May 2013 09:21:01 +0200
Subject: [PATCH v2] usb: musb: fix clock naming
Message-ID: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

'ick' was changed to 'hsotgusb_ick'
'fck' was changed to 'hsotgusb_fck'

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: CC linux-usb mailing list

 drivers/usb/musb/am35x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 2231850..92b5b23 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -477,14 +477,14 @@ static int am35x_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	phy_clk = clk_get(&pdev->dev, "fck");
+	phy_clk = clk_get(&pdev->dev, "hsotgusb_ick");
 	if (IS_ERR(phy_clk)) {
 		dev_err(&pdev->dev, "failed to get PHY clock\n");
 		ret = PTR_ERR(phy_clk);
 		goto err3;
 	}
 
-	clk = clk_get(&pdev->dev, "ick");
+	clk = clk_get(&pdev->dev, "hsotgusb_fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-- 
1.7.7
