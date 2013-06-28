From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Jun 2013 11:17:48 -0700
Subject: [PATCH 1/2] ASoC: ac97: pxa2xx: fixup multi-platform AC'97 build
 failures
In-Reply-To: <1372443469-20191-1-git-send-email-khilman@linaro.org>
References: <1372443469-20191-1-git-send-email-khilman@linaro.org>
Message-ID: <1372443469-20191-2-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b047e1cc (ASoC: ac97: Support multi-platform AC'97) introduced
some build failures for the pxa2xx-ac97 support, fix them.

Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 sound/soc/pxa/pxa2xx-ac97.c | 2 ++
 sound/soc/pxa/pxa2xx-ac97.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index a3c22ba..1475515 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -238,6 +238,8 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
 		return -ENXIO;
diff --git a/sound/soc/pxa/pxa2xx-ac97.h b/sound/soc/pxa/pxa2xx-ac97.h
index eda891e..a49c21b 100644
--- a/sound/soc/pxa/pxa2xx-ac97.h
+++ b/sound/soc/pxa/pxa2xx-ac97.h
@@ -14,7 +14,4 @@
 #define PXA2XX_DAI_AC97_AUX		1
 #define PXA2XX_DAI_AC97_MIC		2
 
-/* platform data */
-extern struct snd_ac97_bus_ops pxa2xx_ac97_ops;
-
 #endif
-- 
1.8.3
