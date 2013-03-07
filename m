From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:16 +0100
Subject: [PATCH 10/11] net/phy: convert to pr_info
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/net/phy/phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 12739ff..112ff13 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -49,7 +49,7 @@ int phy_update_status(struct phy_device *dev)
 		dev->adjust_link(edev);
 
 	if (dev->link)
-		printf("%dMbps %s duplex link detected\n", dev->speed,
+		pr_info("%dMbps %s duplex link detected\n", dev->speed,
 			dev->duplex ? "full" : "half");
 
 	return 0;
-- 
1.7.10.4
