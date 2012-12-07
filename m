From: wfp5p@virginia.edu (Bill Pemberton)
Date: Fri,  7 Dec 2012 09:26:15 -0500
Subject: [PATCH 03/25] ASoC: Samsung: remove __dev* attributes
In-Reply-To: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1354890397-28568-4-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 sound/soc/samsung/ac97.c                       | 6 +++---
 sound/soc/samsung/bells.c                      | 6 +++---
 sound/soc/samsung/dma.c                        | 4 ++--
 sound/soc/samsung/i2s.c                        | 9 ++++-----
 sound/soc/samsung/idma.c                       | 6 +++---
 sound/soc/samsung/littlemill.c                 | 6 +++---
 sound/soc/samsung/lowland.c                    | 6 +++---
 sound/soc/samsung/pcm.c                        | 6 +++---
 sound/soc/samsung/s3c2412-i2s.c                | 6 +++---
 sound/soc/samsung/s3c24xx-i2s.c                | 6 +++---
 sound/soc/samsung/s3c24xx_simtec.c             | 6 +++---
 sound/soc/samsung/s3c24xx_simtec_hermes.c      | 4 ++--
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c | 4 ++--
 sound/soc/samsung/smdk_wm8580pcm.c             | 6 +++---
 sound/soc/samsung/smdk_wm8994.c                | 6 +++---
 sound/soc/samsung/smdk_wm8994pcm.c             | 6 +++---
 sound/soc/samsung/spdif.c                      | 6 +++---
 sound/soc/samsung/speyside.c                   | 6 +++---
 sound/soc/samsung/tobermory.c                  | 6 +++---
 19 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index cd6c707..0df3c56 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -370,7 +370,7 @@ static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	},
 };
 
-static __devinit int s3c_ac97_probe(struct platform_device *pdev)
+static int s3c_ac97_probe(struct platform_device *pdev)
 {
 	struct resource *mem_res, *dmatx_res, *dmarx_res, *dmamic_res, *irq_res;
 	struct s3c_audio_pdata *ac97_pdata;
@@ -485,7 +485,7 @@ err1:
 	return ret;
 }
 
-static __devexit int s3c_ac97_remove(struct platform_device *pdev)
+static int s3c_ac97_remove(struct platform_device *pdev)
 {
 	struct resource *mem_res, *irq_res;
 
@@ -510,7 +510,7 @@ static __devexit int s3c_ac97_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c_ac97_driver = {
 	.probe  = s3c_ac97_probe,
-	.remove = __devexit_p(s3c_ac97_remove),
+	.remove = s3c_ac97_remove,
 	.driver = {
 		.name = "samsung-ac97",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 01c1c5a..ceed466 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -412,7 +412,7 @@ static struct snd_soc_card bells_cards[] = {
 };
 
 
-static __devinit int bells_probe(struct platform_device *pdev)
+static int bells_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -429,7 +429,7 @@ static __devinit int bells_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bells_remove(struct platform_device *pdev)
+static int bells_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&bells_cards[pdev->id]);
 
@@ -443,7 +443,7 @@ static struct platform_driver bells_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bells_probe,
-	.remove = __devexit_p(bells_remove),
+	.remove = bells_remove,
 };
 
 module_platform_driver(bells_driver);
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 6452990..db87628 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -432,13 +432,13 @@ static struct snd_soc_platform_driver samsung_asoc_platform = {
 	.pcm_free	= dma_free_dma_buffers,
 };
 
-int __devinit asoc_dma_platform_register(struct device *dev)
+int asoc_dma_platform_register(struct device *dev)
 {
 	return snd_soc_register_platform(dev, &samsung_asoc_platform);
 }
 EXPORT_SYMBOL_GPL(asoc_dma_platform_register);
 
-void __devexit asoc_dma_platform_unregister(struct device *dev)
+void asoc_dma_platform_unregister(struct device *dev)
 {
 	snd_soc_unregister_platform(dev);
 }
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0aa0451..d2d124f 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -952,8 +952,7 @@ static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 					SNDRV_PCM_FMTBIT_S16_LE | \
 					SNDRV_PCM_FMTBIT_S24_LE)
 
-static __devinit
-struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
+static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 {
 	struct i2s_dai *i2s;
 
@@ -994,7 +993,7 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
 }
 
-static __devinit int samsung_i2s_probe(struct platform_device *pdev)
+static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1117,7 +1116,7 @@ err:
 	return ret;
 }
 
-static __devexit int samsung_i2s_remove(struct platform_device *pdev)
+static int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct i2s_dai *i2s, *other;
 	struct resource *res;
@@ -1146,7 +1145,7 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
-	.remove = __devexit_p(samsung_i2s_remove),
+	.remove = samsung_i2s_remove,
 	.driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index c227c31..a07950b 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -416,12 +416,12 @@ static struct snd_soc_platform_driver asoc_idma_platform = {
 	.pcm_free = idma_free,
 };
 
-static int __devinit asoc_idma_platform_probe(struct platform_device *pdev)
+static int asoc_idma_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
 }
 
-static int __devexit asoc_idma_platform_remove(struct platform_device *pdev)
+static int asoc_idma_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -434,7 +434,7 @@ static struct platform_driver asoc_idma_driver = {
 	},
 
 	.probe = asoc_idma_platform_probe,
-	.remove = __devexit_p(asoc_idma_platform_remove),
+	.remove = asoc_idma_platform_remove,
 };
 
 module_platform_driver(asoc_idma_driver);
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index de4cfdf..bfb91f3 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -297,7 +297,7 @@ static struct snd_soc_card littlemill = {
 	.late_probe = littlemill_late_probe,
 };
 
-static __devinit int littlemill_probe(struct platform_device *pdev)
+static int littlemill_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &littlemill;
 	int ret;
@@ -314,7 +314,7 @@ static __devinit int littlemill_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit littlemill_remove(struct platform_device *pdev)
+static int littlemill_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -330,7 +330,7 @@ static struct platform_driver littlemill_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = littlemill_probe,
-	.remove = __devexit_p(littlemill_remove),
+	.remove = littlemill_remove,
 };
 
 module_platform_driver(littlemill_driver);
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index a71c31a..570cf52 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -180,7 +180,7 @@ static struct snd_soc_card lowland = {
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
-static __devinit int lowland_probe(struct platform_device *pdev)
+static int lowland_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &lowland;
 	int ret;
@@ -197,7 +197,7 @@ static __devinit int lowland_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit lowland_remove(struct platform_device *pdev)
+static int lowland_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -213,7 +213,7 @@ static struct platform_driver lowland_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = lowland_probe,
-	.remove = __devexit_p(lowland_remove),
+	.remove = lowland_remove,
 };
 
 module_platform_driver(lowland_driver);
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index ecd5090..13bab79 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -490,7 +490,7 @@ static struct snd_soc_dai_driver s3c_pcm_dai[] = {
 	},
 };
 
-static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
+static int s3c_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_pcm_info *pcm;
 	struct resource *mem_res, *dmatx_res, *dmarx_res;
@@ -613,7 +613,7 @@ err1:
 	return ret;
 }
 
-static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
+static int s3c_pcm_dev_remove(struct platform_device *pdev)
 {
 	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
 	struct resource *mem_res;
@@ -638,7 +638,7 @@ static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c_pcm_driver = {
 	.probe  = s3c_pcm_dev_probe,
-	.remove = __devexit_p(s3c_pcm_dev_remove),
+	.remove = s3c_pcm_dev_remove,
 	.driver = {
 		.name = "samsung-pcm",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index edf5f527..2213377 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -160,7 +160,7 @@ static struct snd_soc_dai_driver s3c2412_i2s_dai = {
 	.ops = &s3c2412_i2s_dai_ops,
 };
 
-static __devinit int s3c2412_iis_dev_probe(struct platform_device *pdev)
+static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -182,7 +182,7 @@ err:
 	return ret;
 }
 
-static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
+static int s3c2412_iis_dev_remove(struct platform_device *pdev)
 {
 	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
@@ -191,7 +191,7 @@ static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c2412_iis_driver = {
 	.probe  = s3c2412_iis_dev_probe,
-	.remove = __devexit_p(s3c2412_iis_dev_remove),
+	.remove = s3c2412_iis_dev_remove,
 	.driver = {
 		.name = "s3c2412-iis",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 0022d51..ee10e87 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -465,7 +465,7 @@ static struct snd_soc_dai_driver s3c24xx_i2s_dai = {
 	.ops = &s3c24xx_i2s_dai_ops,
 };
 
-static __devinit int s3c24xx_iis_dev_probe(struct platform_device *pdev)
+static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -487,7 +487,7 @@ err:
 	return ret;
 }
 
-static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
+static int s3c24xx_iis_dev_remove(struct platform_device *pdev)
 {
 	asoc_dma_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
@@ -496,7 +496,7 @@ static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c24xx_iis_driver = {
 	.probe  = s3c24xx_iis_dev_probe,
-	.remove = __devexit_p(s3c24xx_iis_dev_remove),
+	.remove = s3c24xx_iis_dev_remove,
 	.driver = {
 		.name = "s3c24xx-iis",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 335a7d8..2c015f6 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -313,8 +313,8 @@ const struct dev_pm_ops simtec_audio_pmops = {
 EXPORT_SYMBOL_GPL(simtec_audio_pmops);
 #endif
 
-int __devinit simtec_audio_core_probe(struct platform_device *pdev,
-				      struct snd_soc_card *card)
+int simtec_audio_core_probe(struct platform_device *pdev,
+			    struct snd_soc_card *card)
 {
 	struct platform_device *snd_dev;
 	int ret;
@@ -371,7 +371,7 @@ err_clk:
 }
 EXPORT_SYMBOL_GPL(simtec_audio_core_probe);
 
-int __devexit simtec_audio_remove(struct platform_device *pdev)
+int simtec_audio_remove(struct platform_device *pdev)
 {
 	struct platform_device *snd_dev = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index befabe8..d8a0543 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -99,7 +99,7 @@ static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
 	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
-static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
+static int simtec_audio_hermes_probe(struct platform_device *pd)
 {
 	dev_info(&pd->dev, "probing....\n");
 	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic33);
@@ -112,7 +112,7 @@ static struct platform_driver simtec_audio_hermes_platdrv = {
 		.pm	= simtec_audio_pm,
 	},
 	.probe	= simtec_audio_hermes_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
+	.remove	= simtec_audio_remove,
 };
 
 module_platform_driver(simtec_audio_hermes_platdrv);
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 5552f82..1ac0d7a 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -88,7 +88,7 @@ static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
 	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
-static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
+static int simtec_audio_tlv320aic23_probe(struct platform_device *pd)
 {
 	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic23);
 }
@@ -100,7 +100,7 @@ static struct platform_driver simtec_audio_tlv320aic23_driver = {
 		.pm	= simtec_audio_pm,
 	},
 	.probe	= simtec_audio_tlv320aic23_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
+	.remove	= simtec_audio_remove,
 };
 
 module_platform_driver(simtec_audio_tlv320aic23_driver);
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index 34239fe..e43bd42 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -153,7 +153,7 @@ static struct snd_soc_card smdk_pcm = {
  * is absent (or not connected), so we connect EXT_VOICE_CLK(OSC4),
  * 2.0484Mhz, directly with MCLK both Codec and SoC.
  */
-static int __devinit snd_smdk_probe(struct platform_device *pdev)
+static int snd_smdk_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -173,7 +173,7 @@ static int __devinit snd_smdk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snd_smdk_remove(struct platform_device *pdev)
+static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
 	platform_set_drvdata(pdev, NULL);
@@ -186,7 +186,7 @@ static struct platform_driver snd_smdk_driver = {
 		.name = "samsung-smdk-pcm",
 	},
 	.probe = snd_smdk_probe,
-	.remove = __devexit_p(snd_smdk_remove),
+	.remove = snd_smdk_remove,
 };
 
 module_platform_driver(snd_smdk_driver);
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index dd0aa8c..b0d0ab8 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -150,7 +150,7 @@ static struct snd_soc_card smdk = {
 };
 
 
-static int __devinit smdk_audio_probe(struct platform_device *pdev)
+static int smdk_audio_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card = &smdk;
@@ -164,7 +164,7 @@ static int __devinit smdk_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit smdk_audio_remove(struct platform_device *pdev)
+static int smdk_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -179,7 +179,7 @@ static struct platform_driver smdk_audio_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= smdk_audio_probe,
-	.remove		= __devexit_p(smdk_audio_remove),
+	.remove		= smdk_audio_remove,
 };
 
 module_platform_driver(smdk_audio_driver);
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 15f6b44..3688a32 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -129,7 +129,7 @@ static struct snd_soc_card smdk_pcm = {
 	.num_links = 1,
 };
 
-static int __devinit snd_smdk_probe(struct platform_device *pdev)
+static int snd_smdk_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -143,7 +143,7 @@ static int __devinit snd_smdk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snd_smdk_remove(struct platform_device *pdev)
+static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
 	platform_set_drvdata(pdev, NULL);
@@ -156,7 +156,7 @@ static struct platform_driver snd_smdk_driver = {
 		.name = "samsung-smdk-pcm",
 	},
 	.probe = snd_smdk_probe,
-	.remove = __devexit_p(snd_smdk_remove),
+	.remove = snd_smdk_remove,
 };
 
 module_platform_driver(snd_smdk_driver);
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 8606fc6..5008e5b 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -357,7 +357,7 @@ static struct snd_soc_dai_driver samsung_spdif_dai = {
 	.resume = spdif_resume,
 };
 
-static __devinit int spdif_probe(struct platform_device *pdev)
+static int spdif_probe(struct platform_device *pdev)
 {
 	struct s3c_audio_pdata *spdif_pdata;
 	struct resource *mem_res, *dma_res;
@@ -460,7 +460,7 @@ err0:
 	return ret;
 }
 
-static __devexit int spdif_remove(struct platform_device *pdev)
+static int spdif_remove(struct platform_device *pdev)
 {
 	struct samsung_spdif_info *spdif = &spdif_info;
 	struct resource *mem_res;
@@ -484,7 +484,7 @@ static __devexit int spdif_remove(struct platform_device *pdev)
 
 static struct platform_driver samsung_spdif_driver = {
 	.probe	= spdif_probe,
-	.remove	= __devexit_p(spdif_remove),
+	.remove	= spdif_remove,
 	.driver	= {
 		.name	= "samsung-spdif",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index d7906a1..57df90d 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -320,7 +320,7 @@ static struct snd_soc_card speyside = {
 	.late_probe = speyside_late_probe,
 };
 
-static __devinit int speyside_probe(struct platform_device *pdev)
+static int speyside_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &speyside;
 	int ret;
@@ -337,7 +337,7 @@ static __devinit int speyside_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit speyside_remove(struct platform_device *pdev)
+static int speyside_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -353,7 +353,7 @@ static struct platform_driver speyside_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = speyside_probe,
-	.remove = __devexit_p(speyside_remove),
+	.remove = speyside_remove,
 };
 
 module_platform_driver(speyside_driver);
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 42e4c8e..f21ff60 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -214,7 +214,7 @@ static struct snd_soc_card tobermory = {
 	.late_probe = tobermory_late_probe,
 };
 
-static __devinit int tobermory_probe(struct platform_device *pdev)
+static int tobermory_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &tobermory;
 	int ret;
@@ -231,7 +231,7 @@ static __devinit int tobermory_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tobermory_remove(struct platform_device *pdev)
+static int tobermory_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -247,7 +247,7 @@ static struct platform_driver tobermory_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = tobermory_probe,
-	.remove = __devexit_p(tobermory_remove),
+	.remove = tobermory_remove,
 };
 
 module_platform_driver(tobermory_driver);
-- 
1.8.0.1
