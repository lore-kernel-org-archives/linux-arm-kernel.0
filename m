From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 29 Apr 2016 21:00:46 +0800
Subject: [alsa-devel] [PATCH 5/7] ASoC: bt-sco: extend rate and add a general
 compatible string
In-Reply-To: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1461934848-60011-6-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add supports for 16k (wideband BT) and add a general compatible
string "linux,bt-sco"

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 Documentation/devicetree/bindings/sound/bt-sco.txt | 2 +-
 sound/soc/codecs/bt-sco.c                          | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
index 29b8e5d..641edf7 100644
--- a/Documentation/devicetree/bindings/sound/bt-sco.txt
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -4,7 +4,7 @@ This device support generic Bluetooth SCO link.
 
 Required properties:
 
-  - compatible : "delta,dfbmcs320"
+  - compatible : "delta,dfbmcs320" or "linux,bt-sco"
 
 Example:
 
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index b084ad1..101b384 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -31,14 +31,14 @@ static struct snd_soc_dai_driver bt_sco_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
 		 .stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 };
@@ -77,6 +77,7 @@ MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 #if defined(CONFIG_OF)
 static const struct of_device_id bt_sco_codec_of_match[] = {
 	{ .compatible = "delta,dfbmcs320", },
+	{ .compatible = "linux,bt-sco", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bt_sco_codec_of_match);
-- 
1.9.1
