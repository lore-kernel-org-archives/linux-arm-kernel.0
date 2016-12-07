From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  7 Dec 2016 10:30:25 -0800
Subject: [PATCH v6 5/5] [media] davinci: VPIF: add basic support for DT init
In-Reply-To: <20161207183025.20684-1-khilman@baylibre.com>
References: <20161207183025.20684-1-khilman@baylibre.com>
Message-ID: <20161207183025.20684-6-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for initialization via DT

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/media/platform/davinci/vpif.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index f50148dcba64..1b02a6363f77 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -467,8 +467,17 @@ static const struct dev_pm_ops vpif_pm = {
 #define vpif_pm_ops NULL
 #endif
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id vpif_of_match[] = {
+	{ .compatible = "ti,da850-vpif", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, vpif_of_match);
+#endif
+
 static struct platform_driver vpif_driver = {
 	.driver = {
+		.of_match_table = of_match_ptr(vpif_of_match),
 		.name	= VPIF_DRIVER_NAME,
 		.pm	= vpif_pm_ops,
 	},
-- 
2.9.3
