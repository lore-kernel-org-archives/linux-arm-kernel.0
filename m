From: ahaslam@baylibre.com (Axel Haslam)
Date: Wed,  2 Nov 2016 13:44:34 +0100
Subject: [PATCH 2/3] phy: da8xx-usb: rename the ohci device to ohci-da8xx
In-Reply-To: <20161102124435.31777-1-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
Message-ID: <20161102124435.31777-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one ohci on the da8xx series of chips,
so remove the ".0" when creating the phy. Also add
the "-da8xx" postfix to be consistent across davinci
usb drivers.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/phy/phy-da8xx-usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
index 32ae78c..c85fb0b 100644
--- a/drivers/phy/phy-da8xx-usb.c
+++ b/drivers/phy/phy-da8xx-usb.c
@@ -198,7 +198,8 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 	} else {
 		int ret;
 
-		ret = phy_create_lookup(d_phy->usb11_phy, "usb-phy", "ohci.0");
+		ret = phy_create_lookup(d_phy->usb11_phy, "usb-phy",
+					"ohci-da8xx");
 		if (ret)
 			dev_warn(dev, "Failed to create usb11 phy lookup\n");
 		ret = phy_create_lookup(d_phy->usb20_phy, "usb-phy",
@@ -216,7 +217,7 @@ static int da8xx_usb_phy_remove(struct platform_device *pdev)
 
 	if (!pdev->dev.of_node) {
 		phy_remove_lookup(d_phy->usb20_phy, "usb-phy", "musb-da8xx");
-		phy_remove_lookup(d_phy->usb11_phy, "usb-phy", "ohci.0");
+		phy_remove_lookup(d_phy->usb11_phy, "usb-phy", "ohci-da8xx");
 	}
 
 	return 0;
-- 
2.10.1
