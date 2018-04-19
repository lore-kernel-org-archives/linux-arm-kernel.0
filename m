From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 14:56:38 +0200
Subject: [PATCH] drm/sun4i: Add missing frontend compatibles for A10, A13,
 A20 and A31
Message-ID: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although frontend nodes are defined in the device-trees of the
aforementioned platforms, there are no matching compatibles defined in
the driver. This makes it impossible to probe the frontend on these
platforms.

Adding the appropriate compatibles to the driver fixes the issue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 85f75046712c..c5a3de11817d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -658,6 +658,10 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 };
 
 const struct of_device_id sun4i_frontend_of_table[] = {
+	{ .compatible = "allwinner,sun7i-a10-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a13-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a20-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a31-display-frontend" },
 	{ .compatible = "allwinner,sun8i-a33-display-frontend" },
 	{ }
 };
-- 
2.16.3
