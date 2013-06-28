From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Jun 2013 11:17:49 -0700
Subject: [PATCH 2/2] ASoC: ac97: fixup multi-platform AC'97 module build
 failure
In-Reply-To: <1372443469-20191-1-git-send-email-khilman@linaro.org>
References: <1372443469-20191-1-git-send-email-khilman@linaro.org>
Message-ID: <1372443469-20191-3-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b047e1cc (ASoC: ac97: Support multi-platform AC'97) introduced
some build failures for modules wanting to access the generic
soc_ac97_ops.  For example:

ERROR: "soc_ac97_ops" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!

To fix, export soc_ac97_ops to modules.

Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 309e5c9..0ec070c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2081,6 +2081,7 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
 struct snd_ac97_bus_ops *soc_ac97_ops;
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops)
 {
-- 
1.8.3
