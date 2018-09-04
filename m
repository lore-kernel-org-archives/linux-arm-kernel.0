From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Sep 2018 12:40:47 +0800
Subject: [PATCH v4 05/11] drm/sun4i: Add support for A64 display engine
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Message-ID: <20180904044053.15425-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Display Engine(DE2) in Allwinner A64 has two mixers and tcons.

The routing for mixer0 is through tcon0 and connected to
LVDS/RGB/MIPI-DSI controller.

The routing for mixer1 is through tcon1 and connected to HDMI.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes for v4, v3.1, v3, v2:
- none

 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8b0cd08034e0..fbd5a3d44d11 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -420,6 +420,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
+	{ .compatible = "allwinner,sun50i-a64-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
-- 
2.18.0
