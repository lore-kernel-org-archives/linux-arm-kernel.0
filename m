From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:43 +0100
Subject: [PATCH net-next v3 4/7] net: phy: meson-gxl: use genphy_config_init
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218094446.31912-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic init function to populate some of the phydev
structure fields

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index a52645566d0d..0a34656a2086 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -147,7 +147,7 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return 0;
+	return genphy_config_init(phydev);
 }
 
 /* This function is provided to cope with the possible failures of this phy
-- 
2.14.3
