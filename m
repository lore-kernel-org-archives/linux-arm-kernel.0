From: peda@axentia.se (Peter Rosin)
Date: Fri, 27 Apr 2018 00:31:37 +0200
Subject: [PATCH 22/24] drm/bridge: remove the .of_node member
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
Message-ID: <20180426223139.16740-23-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is unused.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 3 +--
 include/drm/drm_bridge.h     | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 67147673fdeb..9f023bd84d56 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,8 +365,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if ((bridge->owner && bridge->owner->of_node == np) ||
-		    bridge->of_node == np) {
+		if (bridge->owner->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c28a75ad0ae2..3bc659f3e7d2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -258,7 +258,6 @@ struct drm_bridge_timings {
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
@@ -270,9 +269,6 @@ struct drm_bridge {
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-#ifdef CONFIG_OF
-	struct device_node *of_node;
-#endif
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
 
-- 
2.11.0
