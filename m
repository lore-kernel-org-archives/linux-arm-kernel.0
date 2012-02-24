From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:38 +0800
Subject: [PATCH 3/6] ASoC: Remove unnecessary -codec from cs4270 driver name
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to what commit 1e3ad57 (ASoC: Remove redundant -codec from
WM8776 driver name) does for wm8776 driver, this patch does the same
thing for cs4270 driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/cs4270.c    |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c |    4 ++--
 sound/soc/pxa/raumfeld.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 6baccd2..1d672f5 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -715,7 +715,7 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
  */
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
-		.name = "cs4270-codec",
+		.name = "cs4270",
 		.owner = THIS_MODULE,
 	},
 	.id_table = cs4270_id,
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 93256b3..fcf9302 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -245,7 +245,7 @@ static int get_parent_cell_index(struct device_node *np)
  * 'struct device'  It's ugly and hackish, but it works.
  *
  * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270-codec.0-004f".
+ * example, "cs4270.0-004f".
  */
 static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 {
@@ -267,7 +267,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	if (!i2c)
 		return -ENODEV;
 
-	snprintf(buf, len, "%s-codec.%u-%04x", temp, i2c->adapter->nr, addr);
+	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index ba15451..0837065 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -232,7 +232,7 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.cpu_dai_name	= "pxa-ssp-dai.0",		\
 	.platform_name	= "pxa-pcm-audio",		\
 	.codec_dai_name	= "cs4270-hifi",		\
-	.codec_name	= "cs4270-codec.0-0048",	\
+	.codec_name	= "cs4270.0-0048",	\
 	.ops		= &raumfeld_cs4270_ops,		\
 }
 
-- 
1.7.5.4
