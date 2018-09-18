From: zhongjiang@huawei.com (zhong jiang)
Date: Tue, 18 Sep 2018 15:25:20 +0800
Subject: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
Message-ID: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile warning:

drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wmaybe-uninitialized]
bool has_lvds_rst, has_lvds_alt, can_lvds;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35..563cc8f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1086,7 +1086,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	struct device_node *remote;
 	struct sun4i_tcon *tcon;
 	struct reset_control *edp_rstc;
-	bool has_lvds_rst, has_lvds_alt, can_lvds;
+	bool has_lvds_rst, has_lvds_alt = false, can_lvds;
 	int ret;
 
 	engine = sun4i_tcon_find_engine(drv, dev->of_node);
-- 
1.7.12.4
