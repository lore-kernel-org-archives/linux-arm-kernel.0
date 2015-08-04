From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 14:02:03 +0000
Subject: [PATCH v2 2/9] usb: phy: phy-keystone: Simplify return statement
In-Reply-To: <cover.1438695318.git.skarajga@visteon.com>
References: <cover.1438695318.git.skarajga@visteon.com>
Message-ID: <40402eeb0cd861569faf838efccc1ef4672da83c.1438695318.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/phy/phy-keystone.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index e0556f7..01d4e4c 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -96,11 +96,7 @@ static int keystone_usbphy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k_phy);
 
-	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
-	if (ret)
-		return ret;
-
-	return 0;
+	return usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
 }
 
 static int keystone_usbphy_remove(struct platform_device *pdev)
-- 
1.9.1
