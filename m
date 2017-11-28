From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Tue, 28 Nov 2017 16:48:55 +0100
Subject: [PATCH v3 2/4] omapdrm: panel: td028ttec1: replace MODULE_ALIAS by
 MODULE_DEVICE_TABLE
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
Message-ID: <655c9a39d590a5fa7187350269c2914b781d84cc.1511884135.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to make it easier to keep in sync with the OF device table.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c      | 12 ++++++++++--
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c | 11 +++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index a0dfa14f4fab..2721a86ac5e7 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -460,9 +460,19 @@ static const struct of_device_id td028ttec1_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
+static const struct spi_device_id td028ttec1_ids[] = {
+	{ "toppoly,td028ttec1", 0 },
+	{ "tpo,td028ttec1", 0},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(spi, td028ttec1_ids);
+
+
 static struct spi_driver td028ttec1_spi_driver = {
 	.probe		= td028ttec1_panel_probe,
 	.remove		= td028ttec1_panel_remove,
+	.id_table	= td028ttec1_ids,
 
 	.driver         = {
 		.name   = "panel-tpo-td028ttec1",
@@ -473,8 +483,6 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:tpo,td028ttec1");
-MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 4aeb908f2d1e..f6da8755b859 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -463,9 +463,18 @@ static const struct of_device_id td028ttec1_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
+static const struct spi_device_id td028ttec1_ids[] = {
+	{ "toppoly,td028ttec1", 0 },
+	{ "tpo,td028ttec1", 0},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(spi, td028ttec1_ids);
+
 static struct spi_driver td028ttec1_spi_driver = {
 	.probe		= td028ttec1_panel_probe,
 	.remove		= td028ttec1_panel_remove,
+	.id_table	= td028ttec1_ids,
 
 	.driver         = {
 		.name   = "panel-tpo-td028ttec1",
@@ -476,8 +485,6 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:tpo,td028ttec1");
-MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
-- 
2.12.2
