From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 10 Aug 2017 04:36:43 +0000
Subject: [PATCH] drm/sun4i: use of_graph_get_remote_endpoint()
Message-ID: <87tw1gxcx8.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, we can use of_graph_get_remote_endpoint(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
- Not tested

 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index cf48021..ec59436 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -312,7 +312,7 @@ static int sun4i_backend_of_get_id(struct device_node *node)
 		struct device_node *remote;
 		u32 reg;
 
-		remote = of_parse_phandle(ep, "remote-endpoint", 0);
+		remote = of_graph_get_remote_endpoint(ep);
 		if (!remote)
 			continue;
 
-- 
1.9.1
