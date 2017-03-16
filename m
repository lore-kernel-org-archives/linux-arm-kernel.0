From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 17 Mar 2017 04:47:45 +0800
Subject: [PATCH v2 5/8] drm/sun4i: tcon: add support for V3s TCON
In-Reply-To: <20170316204748.8596-1-icenowy@aosc.xyz>
References: <20170316204748.8596-1-icenowy@aosc.xyz>
Message-ID: <20170316204748.8596-6-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a TCON without channel 1.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c  | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e78b8aaa4019..aad6a1a4664c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -186,7 +186,8 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
-		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon");
+		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun8i-v3s-tcon");
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f4f7283f7cb2..110e432b766d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -613,11 +613,16 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	/* nothing is supported */
 };
 
+static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
+	/* nothing is supported */
+};
+
 static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
+	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
-- 
2.12.0
