From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 21 Jun 2017 19:51:43 +0900
Subject: [PATCH v4] drm/exynos/dsi: Remove error handling for bridge_node DT
 parsing
References: <CGME20170621105143epcas5p4b5c7fbbc0263c6190e69df6822e63699@epcas5p4.samsung.com>
Message-ID: <1498042303-5673-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the error handling of bridge_node because the bridge_node is
optional.

For example, In case of Exynos SoC, a bridge device such as mDNIe and
MIC could be placed between Display Controller and MIPI DSI device but
the bridge device is optional.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---

Hi all,

Thanks for Krzysztof's advice.

Changes for V4:
- Fixed the word('optional') from commit message.

Changes for V3:
- Removed the word('required') from commit message.

Changes for V2:
- Modified the commit message in more detail than before.

Best regards,
Hoegeun

 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index a11b795..6ee0dac 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1651,8 +1651,6 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
 		return ret;
 
 	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
-	if (!dsi->bridge_node)
-		return -EINVAL;
 
 	return 0;
 }
-- 
1.9.1
