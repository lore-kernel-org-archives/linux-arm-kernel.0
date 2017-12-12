From: colin.king@canonical.com (Colin King)
Date: Tue, 12 Dec 2017 13:03:11 +0000
Subject: [PATCH][next] net: phy: meson-gxl: make function
 meson_gxl_read_status static
Message-ID: <20171212130311.17185-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The function meson_gxl_read_status is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
symbol 'meson_gxl_read_status' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/phy/meson-gxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index c64b81e50f60..4ee630afe43a 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -67,7 +67,7 @@ static int meson_gxl_config_init(struct phy_device *phydev)
  * When this failure happens, the first retry is usually successful but,
  * in some cases, it may take up to 6 retries to get a decent result
  */
-int meson_gxl_read_status(struct phy_device *phydev)
+static int meson_gxl_read_status(struct phy_device *phydev)
 {
 	int ret, wol, lpa, exp;
 
-- 
2.14.1
