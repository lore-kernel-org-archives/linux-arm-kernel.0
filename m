From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 15:37:57 +0100
Subject: [PATCH 2/4] ASoC: wm9713: add device tree support
In-Reply-To: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1455979079-9030-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the code to be able to use this codec in a devicetree platform.
This is tested with the zylonite pxa310 board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/wm9713.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 79e143625ac3..4e522302bb8a 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1272,9 +1272,19 @@ static int wm9713_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id wm9713_dt_ids[] = {
+	{ .compatible = "wlf,wm9713", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm9713_dt_ids);
+
+#endif
+
 static struct platform_driver wm9713_codec_driver = {
 	.driver = {
 			.name = "wm9713-codec",
+			.of_match_table = of_match_ptr(wm9713_dt_ids),
 	},
 
 	.probe = wm9713_probe,
-- 
2.1.4
