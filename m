From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:25 +0100
Subject: [PATCH 5/9] drm: replace "drm_connector_unreference" with
 "drm_connector_put"
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-6-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch unifies the naming of DRM functions for reference counting as
requested on Documentation/gpu/todo.rst

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/bridge/tc358764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index ee6b98efa9c2..afd491018bfc 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -379,7 +379,7 @@ static void tc358764_detach(struct drm_bridge *bridge)
 	drm_fb_helper_remove_one_connector(drm->fb_helper, &ctx->connector);
 	drm_panel_detach(ctx->panel);
 	ctx->panel = NULL;
-	drm_connector_unreference(&ctx->connector);
+	drm_connector_put(&ctx->connector);
 }
 
 static const struct drm_bridge_funcs tc358764_bridge_funcs = {
-- 
2.19.1
