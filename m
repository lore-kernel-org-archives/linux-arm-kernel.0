From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:11 +0100
Subject: [PATCH net-next v2 4/8] net: phy: meson-gxl: use genphy_config_init
In-Reply-To: <20171207142715.32578-1-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
Message-ID: <20171207142715.32578-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic init function to populate some of the phydev
structure fields

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 05054770aefb..2e8c40df33c2 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -142,7 +142,7 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return 0;
+	return genphy_config_init(phydev);
 }
 
 static struct phy_driver meson_gxl_phy[] = {
-- 
2.14.3
