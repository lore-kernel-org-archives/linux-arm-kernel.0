From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:46 +0530
Subject: [PATCH v1 08/14] drm: exynos: hdmi: add support for exynos5 hdmiphy
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-9-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for exynos5 hdmi phy with device tree enabled.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmiphy.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy.c b/drivers/gpu/drm/exynos/exynos_hdmiphy.c
index 9fe2995..a33073b 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy.c
@@ -42,13 +42,23 @@ static int hdmiphy_remove(struct i2c_client *client)
 
 static const struct i2c_device_id hdmiphy_id[] = {
 	{ "s5p_hdmiphy", 0 },
+	{ "exynos5-hdmiphy", 0 },
 	{ },
 };
 
+static struct of_device_id hdmiphy_match_types[] = {
+	{
+		.compatible = "samsung,exynos5-hdmiphy",
+	}, {
+		/* end node */
+	}
+};
+
 struct i2c_driver hdmiphy_driver = {
 	.driver = {
-		.name	= "s5p-hdmiphy",
+		.name	= "exynos-hdmiphy",
 		.owner	= THIS_MODULE,
+		.of_match_table = hdmiphy_match_types,
 	},
 	.id_table = hdmiphy_id,
 	.probe		= hdmiphy_probe,
-- 
1.7.0.4
