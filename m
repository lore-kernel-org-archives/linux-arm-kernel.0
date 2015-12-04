From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 21:57:01 +0800
Subject: [PATCH 2/2] phy: berlin-usb: don't set device's driver_data
In-Reply-To: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
References: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449237421-5552-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 739ae3452d0e ("phy: berlin-usb: Set drvdata for phy and
use it"), we get the address of priv by phy_get_drvdata(), so there's
no need to set device's driver_data any more. This patch removes the
call of platform_set_drvdata().

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/phy/phy-berlin-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
index 7bbb473..2017751 100644
--- a/drivers/phy/phy-berlin-usb.c
+++ b/drivers/phy/phy-berlin-usb.c
@@ -193,7 +193,6 @@ static int phy_berlin_usb_probe(struct platform_device *pdev)
 		return PTR_ERR(phy);
 	}
 
-	platform_set_drvdata(pdev, priv);
 	phy_set_drvdata(phy, priv);
 
 	phy_provider =
-- 
2.6.2
