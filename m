From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:58 +0200
Subject: [PATCH 05/13] scpi: move of_match table before probe functions
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the of_match table to prapre adding new compatible strings, with
match data in order to be used by the probe function.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index bb9965f..b0d911b 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -972,6 +972,13 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 	return 0;
 }
 
+static const struct of_device_id scpi_of_match[] = {
+	{.compatible = "arm,scpi"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, scpi_of_match);
+
 static int scpi_probe(struct platform_device *pdev)
 {
 	int count, idx, ret;
@@ -1069,13 +1076,6 @@ err:
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
-static const struct of_device_id scpi_of_match[] = {
-	{.compatible = "arm,scpi"},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, scpi_of_match);
-
 static struct platform_driver scpi_driver = {
 	.driver = {
 		.name = "scpi_protocol",
-- 
1.9.1
