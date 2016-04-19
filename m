From: pc.liao@mediatek.com (PC Liao)
Date: Tue, 19 Apr 2016 19:36:41 +0800
Subject: [PATCH] ASoC: core: export snd_soc_get_dai_name
Message-ID: <1461065801-19535-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Francois Moine <moinejf@free.fr>

snd_soc_get_dai_name() may be used to define a sound card with
a different syntax from the one of the simple-card.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
[1] is applied and needs this patch.
Otherwise, [1] will build fail.

[1] https://patchwork.kernel.org/patch/8878491/
("ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver")
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..03b2d19 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1669,6 +1669,8 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
 				     struct device_node **framemaster);
+int snd_soc_get_dai_name(struct of_phandle_args *args,
+			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b15..69cbbb0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3786,8 +3786,8 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
-static int snd_soc_get_dai_name(struct of_phandle_args *args,
-				const char **dai_name)
+int snd_soc_get_dai_name(struct of_phandle_args *args,
+			 const char **dai_name)
 {
 	struct snd_soc_component *pos;
 	struct device_node *component_of_node;
@@ -3838,6 +3838,7 @@ static int snd_soc_get_dai_name(struct of_phandle_args *args,
 	mutex_unlock(&client_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_get_dai_name);
 
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name)
-- 
1.7.9.5
