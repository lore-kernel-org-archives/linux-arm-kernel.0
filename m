From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:08:35 +0000
Subject: [PATCH 1/9] usb: phy: phy-mxs-usb: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <0e24e9030dc43d6191c74039faf79de49e45c191.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/phy/phy-mxs-usb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 3fcc048..4d863eb 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -506,11 +506,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
-	ret = usb_add_phy_dev(&mxs_phy->phy);
-	if (ret)
-		return ret;
-
-	return 0;
+	return usb_add_phy_dev(&mxs_phy->phy);
 }
 
 static int mxs_phy_remove(struct platform_device *pdev)
-- 
1.9.1
