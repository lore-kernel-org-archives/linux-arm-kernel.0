From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:51 +0200
Subject: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/wm9712.txt | 10 ++++++++++
 sound/soc/codecs/wm9712.c                          |  9 +++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm9712.txt

diff --git a/Documentation/devicetree/bindings/sound/wm9712.txt b/Documentation/devicetree/bindings/sound/wm9712.txt
new file mode 100644
index 0000000..d29f673
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm9712.txt
@@ -0,0 +1,10 @@
+WM9712 audio CODEC
+
+Required properties:
+  - compatible : "wlf,wm9712"
+
+Example:
+
+wm9712: codec {
+	compatible = "wlf,wm9712";
+};
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index c5eb746..d619cdc 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -697,10 +697,19 @@ static int wm9712_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wm9712_codec_of_dev_id[] = {
+	{
+		.compatible = "wlf,wm9712",
+	}, {
+		/* sentinel */
+	}
+};
+
 static struct platform_driver wm9712_codec_driver = {
 	.driver = {
 		.name = "wm9712-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = wm9712_codec_of_dev_id,
 	},
 
 	.probe = wm9712_probe,
-- 
1.8.3.2
