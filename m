From: wfp5p@virginia.edu (Bill Pemberton)
Date: Fri,  7 Dec 2012 09:26:17 -0500
Subject: [PATCH 05/25] ASoC: pxa: remove __dev* attributes
In-Reply-To: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1354890397-28568-6-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/pxa/brownstone.c     | 6 +++---
 sound/soc/pxa/corgi.c          | 6 +++---
 sound/soc/pxa/e740_wm9705.c    | 6 +++---
 sound/soc/pxa/e750_wm9705.c    | 6 +++---
 sound/soc/pxa/e800_wm9712.c    | 6 +++---
 sound/soc/pxa/imote2.c         | 6 +++---
 sound/soc/pxa/mioa701_wm9713.c | 6 +++---
 sound/soc/pxa/mmp-pcm.c        | 6 +++---
 sound/soc/pxa/mmp-sspa.c       | 6 +++---
 sound/soc/pxa/palm27x.c        | 4 ++--
 sound/soc/pxa/poodle.c         | 6 +++---
 sound/soc/pxa/pxa-ssp.c        | 6 +++---
 sound/soc/pxa/pxa2xx-ac97.c    | 8 ++++----
 sound/soc/pxa/pxa2xx-i2s.c     | 4 ++--
 sound/soc/pxa/pxa2xx-pcm.c     | 6 +++---
 sound/soc/pxa/tosa.c           | 6 +++---
 sound/soc/pxa/ttc-dkb.c        | 6 +++---
 17 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 5e666e0..4ad7609 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -140,7 +140,7 @@ static struct snd_soc_card brownstone = {
 	.num_dapm_routes = ARRAY_SIZE(brownstone_audio_map),
 };
 
-static int __devinit brownstone_probe(struct platform_device *pdev)
+static int brownstone_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -152,7 +152,7 @@ static int __devinit brownstone_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit brownstone_remove(struct platform_device *pdev)
+static int brownstone_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&brownstone);
 	return 0;
@@ -164,7 +164,7 @@ static struct platform_driver mmp_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= brownstone_probe,
-	.remove		= __devexit_p(brownstone_remove),
+	.remove		= brownstone_remove,
 };
 
 module_platform_driver(mmp_driver);
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 863367a..f4cce1e 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -303,7 +303,7 @@ static struct snd_soc_card corgi = {
 	.num_dapm_routes = ARRAY_SIZE(corgi_audio_map),
 };
 
-static int __devinit corgi_probe(struct platform_device *pdev)
+static int corgi_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &corgi;
 	int ret;
@@ -317,7 +317,7 @@ static int __devinit corgi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit corgi_remove(struct platform_device *pdev)
+static int corgi_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -331,7 +331,7 @@ static struct platform_driver corgi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= corgi_probe,
-	.remove		= __devexit_p(corgi_remove),
+	.remove		= corgi_remove,
 };
 
 module_platform_driver(corgi_driver);
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 7b1bc2390..70d799b 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -144,7 +144,7 @@ static struct gpio e740_audio_gpios[] = {
 	{ GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH, "Audio power" },
 };
 
-static int __devinit e740_probe(struct platform_device *pdev)
+static int e740_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e740;
 	int ret;
@@ -165,7 +165,7 @@ static int __devinit e740_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e740_remove(struct platform_device *pdev)
+static int e740_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -180,7 +180,7 @@ static struct platform_driver e740_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e740_probe,
-	.remove		= __devexit_p(e740_remove),
+	.remove		= e740_remove,
 };
 
 module_platform_driver(e740_driver);
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 47b89d7..f94d2ab 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -126,7 +126,7 @@ static struct gpio e750_audio_gpios[] = {
 	{ GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
 };
 
-static int __devinit e750_probe(struct platform_device *pdev)
+static int e750_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e750;
 	int ret;
@@ -147,7 +147,7 @@ static int __devinit e750_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e750_remove(struct platform_device *pdev)
+static int e750_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -162,7 +162,7 @@ static struct platform_driver e750_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e750_probe,
-	.remove		= __devexit_p(e750_remove),
+	.remove		= e750_remove,
 };
 
 module_platform_driver(e750_driver);
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index ea9707e..8768a64 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -116,7 +116,7 @@ static struct gpio e800_audio_gpios[] = {
 	{ GPIO_E800_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
 };
 
-static int __devinit e800_probe(struct platform_device *pdev)
+static int e800_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e800;
 	int ret;
@@ -137,7 +137,7 @@ static int __devinit e800_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e800_remove(struct platform_device *pdev)
+static int e800_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -152,7 +152,7 @@ static struct platform_driver e800_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e800_probe,
-	.remove		= __devexit_p(e800_remove),
+	.remove		= e800_remove,
 };
 
 module_platform_driver(e800_driver);
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index b93dafd..eef1f7b 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -65,7 +65,7 @@ static struct snd_soc_card imote2 = {
 	.num_links = 1,
 };
 
-static int __devinit imote2_probe(struct platform_device *pdev)
+static int imote2_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &imote2;
 	int ret;
@@ -79,7 +79,7 @@ static int __devinit imote2_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit imote2_remove(struct platform_device *pdev)
+static int imote2_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -93,7 +93,7 @@ static struct platform_driver imote2_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= imote2_probe,
-	.remove		= __devexit_p(imote2_remove),
+	.remove		= imote2_remove,
 };
 
 module_platform_driver(imote2_driver);
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 8687c1c..97b711e 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -186,7 +186,7 @@ static struct snd_soc_card mioa701 = {
 	.num_links = ARRAY_SIZE(mioa701_dai),
 };
 
-static int __devinit mioa701_wm9713_probe(struct platform_device *pdev)
+static int mioa701_wm9713_probe(struct platform_device *pdev)
 {
 	int rc;
 
@@ -202,7 +202,7 @@ static int __devinit mioa701_wm9713_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
+static int mioa701_wm9713_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -212,7 +212,7 @@ static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
 
 static struct platform_driver mioa701_wm9713_driver = {
 	.probe		= mioa701_wm9713_probe,
-	.remove		= __devexit_p(mioa701_wm9713_remove),
+	.remove		= mioa701_wm9713_remove,
 	.driver		= {
 		.name		= "mioa701-wm9713",
 		.owner		= THIS_MODULE,
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index e834faf..190eb0b 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -257,7 +257,7 @@ struct snd_soc_platform_driver mmp_soc_platform = {
 	.pcm_free	= mmp_pcm_free_dma_buffers,
 };
 
-static __devinit int mmp_pcm_probe(struct platform_device *pdev)
+static int mmp_pcm_probe(struct platform_device *pdev)
 {
 	struct mmp_audio_platdata *pdata = pdev->dev.platform_data;
 
@@ -274,7 +274,7 @@ static __devinit int mmp_pcm_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
 }
 
-static int __devexit mmp_pcm_remove(struct platform_device *pdev)
+static int mmp_pcm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -287,7 +287,7 @@ static struct platform_driver mmp_pcm_driver = {
 	},
 
 	.probe = mmp_pcm_probe,
-	.remove = __devexit_p(mmp_pcm_remove),
+	.remove = mmp_pcm_remove,
 };
 
 module_platform_driver(mmp_pcm_driver);
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 4d6cb8a..41c3a09 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -405,7 +405,7 @@ struct snd_soc_dai_driver mmp_sspa_dai = {
 	.ops = &mmp_sspa_dai_ops,
 };
 
-static __devinit int asoc_mmp_sspa_probe(struct platform_device *pdev)
+static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 {
 	struct sspa_priv *priv;
 	struct resource *res;
@@ -453,7 +453,7 @@ static __devinit int asoc_mmp_sspa_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &mmp_sspa_dai);
 }
 
-static int __devexit asoc_mmp_sspa_remove(struct platform_device *pdev)
+static int asoc_mmp_sspa_remove(struct platform_device *pdev)
 {
 	struct sspa_priv *priv = platform_get_drvdata(pdev);
 
@@ -470,7 +470,7 @@ static struct platform_driver asoc_mmp_sspa_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = asoc_mmp_sspa_probe,
-	.remove = __devexit_p(asoc_mmp_sspa_remove),
+	.remove = asoc_mmp_sspa_remove,
 };
 
 module_platform_driver(asoc_mmp_sspa_driver);
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index aa3da91..2074e2d 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -187,7 +187,7 @@ put_device:
 	return ret;
 }
 
-static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
+static int palm27x_asoc_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(palm27x_snd_device);
 	return 0;
@@ -195,7 +195,7 @@ static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
 
 static struct platform_driver palm27x_wm9712_driver = {
 	.probe		= palm27x_asoc_probe,
-	.remove		= __devexit_p(palm27x_asoc_remove),
+	.remove		= palm27x_asoc_remove,
 	.driver		= {
 		.name		= "palm27x-asoc",
 		.owner		= THIS_MODULE,
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index d2cc8173..fafe463 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -269,7 +269,7 @@ static struct snd_soc_card poodle = {
 	.num_dapm_routes = ARRAY_SIZE(poodle_audio_map),
 };
 
-static int __devinit poodle_probe(struct platform_device *pdev)
+static int poodle_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &poodle;
 	int ret;
@@ -291,7 +291,7 @@ static int __devinit poodle_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit poodle_remove(struct platform_device *pdev)
+static int poodle_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -305,7 +305,7 @@ static struct platform_driver poodle_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= poodle_probe,
-	.remove		= __devexit_p(poodle_remove),
+	.remove		= poodle_remove,
 };
 
 module_platform_driver(poodle_driver);
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4da5fc5..d3eb0c2 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -794,12 +794,12 @@ static struct snd_soc_dai_driver pxa_ssp_dai = {
 		.ops = &pxa_ssp_dai_ops,
 };
 
-static __devinit int asoc_ssp_probe(struct platform_device *pdev)
+static int asoc_ssp_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_dai(&pdev->dev, &pxa_ssp_dai);
 }
 
-static int __devexit asoc_ssp_remove(struct platform_device *pdev)
+static int asoc_ssp_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
@@ -812,7 +812,7 @@ static struct platform_driver asoc_ssp_driver = {
 	},
 
 	.probe = asoc_ssp_probe,
-	.remove = __devexit_p(asoc_ssp_remove),
+	.remove = asoc_ssp_remove,
 };
 
 module_platform_driver(asoc_ssp_driver);
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 06ea2744..4b0a009 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -104,7 +104,7 @@ static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
 #define pxa2xx_ac97_resume	NULL
 #endif
 
-static int __devinit pxa2xx_ac97_probe(struct snd_soc_dai *dai)
+static int pxa2xx_ac97_probe(struct snd_soc_dai *dai)
 {
 	return pxa2xx_ac97_hw_probe(to_platform_device(dai->dev));
 }
@@ -234,7 +234,7 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-static __devinit int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
+static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
@@ -249,7 +249,7 @@ static __devinit int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 			ARRAY_SIZE(pxa_ac97_dai_driver));
 }
 
-static int __devexit pxa2xx_ac97_dev_remove(struct platform_device *pdev)
+static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(pxa_ac97_dai_driver));
 	return 0;
@@ -257,7 +257,7 @@ static int __devexit pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver pxa2xx_ac97_driver = {
 	.probe		= pxa2xx_ac97_dev_probe,
-	.remove		= __devexit_p(pxa2xx_ac97_dev_remove),
+	.remove		= pxa2xx_ac97_dev_remove,
 	.driver		= {
 		.name	= "pxa2xx-ac97",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3075a42..6b1a06f 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -365,7 +365,7 @@ static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &pxa_i2s_dai);
 }
 
-static int __devexit pxa2xx_i2s_drv_remove(struct platform_device *pdev)
+static int pxa2xx_i2s_drv_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
@@ -373,7 +373,7 @@ static int __devexit pxa2xx_i2s_drv_remove(struct platform_device *pdev)
 
 static struct platform_driver pxa2xx_i2s_driver = {
 	.probe = pxa2xx_i2s_drv_probe,
-	.remove = __devexit_p(pxa2xx_i2s_drv_remove),
+	.remove = pxa2xx_i2s_drv_remove,
 
 	.driver = {
 		.name = "pxa2xx-i2s",
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index fdd6bed..ecff116 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -120,12 +120,12 @@ static struct snd_soc_platform_driver pxa2xx_soc_platform = {
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
-static int __devinit pxa2xx_soc_platform_probe(struct platform_device *pdev)
+static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
 }
 
-static int __devexit pxa2xx_soc_platform_remove(struct platform_device *pdev)
+static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -138,7 +138,7 @@ static struct platform_driver pxa_pcm_driver = {
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-	.remove = __devexit_p(pxa2xx_soc_platform_remove),
+	.remove = pxa2xx_soc_platform_remove,
 };
 
 module_platform_driver(pxa_pcm_driver);
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 2aec63f..a3fe191 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -241,7 +241,7 @@ static struct snd_soc_card tosa = {
 	.num_links = ARRAY_SIZE(tosa_dai),
 };
 
-static int __devinit tosa_probe(struct platform_device *pdev)
+static int tosa_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &tosa;
 	int ret;
@@ -262,7 +262,7 @@ static int __devinit tosa_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit tosa_remove(struct platform_device *pdev)
+static int tosa_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -277,7 +277,7 @@ static struct platform_driver tosa_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tosa_probe,
-	.remove		= __devexit_p(tosa_remove),
+	.remove		= tosa_remove,
 };
 
 module_platform_driver(tosa_driver);
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 935491a..f4ea4f6 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -131,7 +131,7 @@ static struct snd_soc_card ttc_dkb_card = {
 	.num_dapm_routes = ARRAY_SIZE(ttc_audio_map),
 };
 
-static int __devinit ttc_dkb_probe(struct platform_device *pdev)
+static int ttc_dkb_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &ttc_dkb_card;
 	int ret;
@@ -146,7 +146,7 @@ static int __devinit ttc_dkb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit ttc_dkb_remove(struct platform_device *pdev)
+static int ttc_dkb_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -161,7 +161,7 @@ static struct platform_driver ttc_dkb_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ttc_dkb_probe,
-	.remove		= __devexit_p(ttc_dkb_remove),
+	.remove		= ttc_dkb_remove,
 };
 
 module_platform_driver(ttc_dkb_driver);
-- 
1.8.0.1
