From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 16 Jun 2017 16:56:59 -0600
Subject: [PATCH] drm: exynos: dsi: fix to return -ENODEV when DSI_PORT_OUT is
 not found
Message-ID: <20170616225659.23569-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix exynos_dsi_parse_dt() to return -ENODEV when of_graph_get_remote_node()
doesn't find DSI_PORT_OUT. -ENODEV is the correct error code to return and
this change makes exynos behavior consistent with rest of the drm drivers.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e337cd2..cb99e82 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1652,7 +1652,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 
 	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_OUT, 0);
 	if (!dsi->bridge_node)
-		return -EINVAL;
+		return -ENODEV;
 
 	return 0;
 }
-- 
2.7.4
