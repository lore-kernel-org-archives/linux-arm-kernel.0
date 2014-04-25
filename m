From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:37 +0100
Subject: [PATCH 143/222] imx-drm: imx-drm-core: fix imx_drm_encoder_get_mux_id
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXZ-0007Mp-UY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

The decoder mux id is equal to the port id of the encoder's input port
that is connected to the given crtc, not to the endpoint id (which is
arbitrary and usually zero).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 4144a75e5f71..bc7f8bd227c7 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -517,7 +517,7 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 		of_node_put(port);
 		if (port == imx_crtc->port) {
 			ret = of_graph_parse_endpoint(ep, &endpoint);
-			return ret ? ret : endpoint.id;
+			return ret ? ret : endpoint.port;
 		}
 	} while (ep);
 
-- 
1.8.3.1
