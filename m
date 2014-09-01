From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 1 Sep 2014 12:29:36 +0800
Subject: [PATCHv1 2/7] ASoC: simple-card: Adjust the comments of simple card.
In-Reply-To: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1409545781-20530-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d45c8dd..e9d5a69 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -131,7 +131,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	*daifmt &= ~(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK);
 
 	/*
-	 * get node via "sound-dai = <&phandle port>"
+	 * Get node via "sound-dai = <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
 	 */
 	node = of_parse_phandle(np, "sound-dai", 0);
@@ -139,12 +139,12 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		return -ENODEV;
 	*p_node = node;
 
-	/* get dai->name */
+	/* Get dai->name */
 	ret = snd_soc_of_get_dai_name(np, name);
 	if (ret < 0)
 		return ret;
 
-	/* parse TDM slot */
+	/* Parse TDM slot */
 	ret = snd_soc_of_parse_tdm_slot(np, &dai->slots, &dai->slot_width);
 	if (ret)
 		return ret;
@@ -189,7 +189,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	daifmt &= (SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK);
 	dai_props->cpu_dai.fmt = dai_props->codec_dai.fmt = daifmt;
 
-	/* Parse CPU DAI */
+	/* Parse CPU DAI node */
 	np = of_get_child_by_name(node, "cpu");
 	if (!np) {
 		ret = -EINVAL;
@@ -207,7 +207,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	dai_props->cpu_dai.fmt |= daifmt;
 	of_node_put(np);
 
-	/* Parse CODEC DAI */
+	/* Parse CODEC DAI node */
 	np = of_get_child_by_name(node, "codec");
 	if (!np) {
 		ret = -EINVAL;
@@ -229,10 +229,10 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 
 	dai_props->codec_dai.fmt |= daifmt;
 
-	/* simple-card assumes platform == cpu */
+	/* Simple Card assumes platform == cpu */
 	dai_link->platform_of_node = dai_link->cpu_of_node;
 
-	/* Link name is created from CPU/CODEC dai name */
+	/* DAI Link's name is created from CPU/CODEC dai name */
 	name = devm_kzalloc(dev,
 			    strlen(dai_link->cpu_dai_name)   +
 			    strlen(dai_link->codec_dai_name) + 2,
@@ -254,7 +254,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		dai_props->codec_dai.sysclk);
 
 	/*
-	 * soc_bind_dai_link() will check cpu name
+	 * asoc_bind_dai_link() will check cpu name
 	 * after of_node matching if dai_link has cpu_dai_name.
 	 * but, it will never match if name was created by fmt_single_name()
 	 * remove cpu_dai_name to escape name matching.
@@ -296,10 +296,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	u32 val;
 	int ret, i = 0;
 
-	/* parsing the card name from DT */
+	/* Parse the card name from DT */
 	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
 
-	/* off-codec widgets */
+	/* Parse off-codec widgets */
 	if (of_property_read_bool(node, "simple-audio-card,widgets")) {
 		ret = snd_soc_of_parse_audio_simple_widgets(&priv->snd_card,
 					"simple-audio-card,widgets");
@@ -352,13 +352,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int num_links, ret;
 
-	/* get the number of DAI links */
+	/* Get the number of DAI links */
 	if (np && of_get_child_by_name(np, "simple-audio-card,dai-link"))
 		num_links = of_get_child_count(np);
 	else
 		return -EINVAL;
 
-	/* allocate the private data and the DAI link array */
+	/* Allocate the private data and the DAI link array */
 	priv = devm_kzalloc(dev,
 			sizeof(*priv) + sizeof(*dai_link) * num_links,
 			GFP_KERNEL);
@@ -366,7 +366,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/*
-	 * init snd_soc_card
+	 * Init snd_soc_card
 	 */
 	priv->snd_card.owner = THIS_MODULE;
 	priv->snd_card.dev = dev;
@@ -374,7 +374,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->snd_card.dai_link = dai_link;
 	priv->snd_card.num_links = num_links;
 
-	/* get room for the other properties */
+	/* Get room for the other properties */
 	priv->dai_props = devm_kzalloc(dev,
 			sizeof(*priv->dai_props) * num_links,
 			GFP_KERNEL);
-- 
1.8.4
