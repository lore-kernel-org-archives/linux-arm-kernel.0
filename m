From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:30 +0200
Subject: [PATCH 3/7] ASoC: stm32: sai: typo fixes
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615334-7156-4-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typos in sai driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     |  2 +-
 sound/soc/stm/stm32_sai.h     |  1 -
 sound/soc/stm/stm32_sai_sub.c | 28 ++++++++++++++--------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 2a27a26..6159d66 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -110,6 +110,6 @@ static int stm32_sai_remove(struct platform_device *pdev)
 module_platform_driver(stm32_sai_driver);
 
 MODULE_DESCRIPTION("STM32 Soc SAI Interface");
-MODULE_AUTHOR("Olivier Moysan, <olivier.moysan@st.com>");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@st.com>");
 MODULE_ALIAS("platform:st,stm32-sai");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index a801fda..270be93 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -125,7 +125,6 @@
 #define SAI_XFRCR_FSOFF		BIT(SAI_XFRCR_FSOFF_SHIFT)
 
 /****************** Bit definition for SAI_XSLOTR register ******************/
-
 #define SAI_XSLOTR_FBOFF_SHIFT	0
 #define SAI_XSLOTR_FBOFF_MASK	GENMASK(4, SAI_XSLOTR_FBOFF_SHIFT)
 #define SAI_XSLOTR_FBOFF_SET(x)	((x) << SAI_XSLOTR_FBOFF_SHIFT)
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index ae4706c..d7aeed3 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -181,29 +181,29 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 			   SAI_XCLRFR_MASK);
 
 	if (flags & SAI_XIMR_OVRUDRIE) {
-		dev_err(&pdev->dev, "IT %s\n",
+		dev_err(&pdev->dev, "IRQ %s\n",
 			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
 	if (flags & SAI_XIMR_MUTEDETIE)
-		dev_dbg(&pdev->dev, "IT mute detected\n");
+		dev_dbg(&pdev->dev, "IRQ mute detected\n");
 
 	if (flags & SAI_XIMR_WCKCFGIE) {
-		dev_err(&pdev->dev, "IT wrong clock configuration\n");
+		dev_err(&pdev->dev, "IRQ wrong clock configuration\n");
 		status = SNDRV_PCM_STATE_DISCONNECTED;
 	}
 
 	if (flags & SAI_XIMR_CNRDYIE)
-		dev_warn(&pdev->dev, "IT Codec not ready\n");
+		dev_err(&pdev->dev, "IRQ Codec not ready\n");
 
 	if (flags & SAI_XIMR_AFSDETIE) {
-		dev_warn(&pdev->dev, "IT Anticipated frame synchro\n");
+		dev_err(&pdev->dev, "IRQ Anticipated frame synchro\n");
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
 	if (flags & SAI_XIMR_LFSDETIE) {
-		dev_warn(&pdev->dev, "IT Late frame synchro\n");
+		dev_err(&pdev->dev, "IRQ Late frame synchro\n");
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
@@ -235,7 +235,7 @@ static int stm32_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int slotr, slotr_mask, slot_size;
 
-	dev_dbg(cpu_dai->dev, "masks tx/rx:%#x/%#x, slots:%d, width:%d\n",
+	dev_dbg(cpu_dai->dev, "Masks tx/rx:%#x/%#x, slots:%d, width:%d\n",
 		tx_mask, rx_mask, slots, slot_width);
 
 	switch (slot_width) {
@@ -377,7 +377,7 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 
 	ret = clk_prepare_enable(sai->sai_ck);
 	if (ret < 0) {
-		dev_err(cpu_dai->dev, "failed to enable clock: %d\n", ret);
+		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
@@ -497,7 +497,7 @@ static int stm32_sai_set_slots(struct snd_soc_dai *cpu_dai)
 				   SAI_XSLOTR_SLOTEN_SET(sai->slot_mask));
 	}
 
-	dev_dbg(cpu_dai->dev, "slots %d, slot width %d\n",
+	dev_dbg(cpu_dai->dev, "Slots %d, slot width %d\n",
 		sai->slots, sai->slot_width);
 
 	return 0;
@@ -521,7 +521,7 @@ static void stm32_sai_set_frame(struct snd_soc_dai *cpu_dai)
 	frcr |= SAI_XFRCR_FSALL_SET((fs_active - 1));
 	frcr_mask = SAI_XFRCR_FRL_MASK | SAI_XFRCR_FSALL_MASK;
 
-	dev_dbg(cpu_dai->dev, "frame length %d, frame active %d\n",
+	dev_dbg(cpu_dai->dev, "Frame length %d, frame active %d\n",
 		sai->fs_length, fs_active);
 
 	regmap_update_bits(sai->regmap, STM_SAI_FRCR_REGX, frcr_mask, frcr);
@@ -784,7 +784,7 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
 	if (IS_ERR(sai->sai_ck)) {
-		dev_err(&pdev->dev, "missing kernel clock sai_ck\n");
+		dev_err(&pdev->dev, "Missing kernel clock sai_ck\n");
 		return PTR_ERR(sai->sai_ck);
 	}
 
@@ -849,7 +849,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, sai->pdata->irq, stm32_sai_isr,
 			       IRQF_SHARED, dev_name(&pdev->dev), sai);
 	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+		dev_err(&pdev->dev, "IRQ request returned %d\n", ret);
 		return ret;
 	}
 
@@ -861,7 +861,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 					      &stm32_sai_pcm_config, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "could not register pcm dma\n");
+		dev_err(&pdev->dev, "Could not register pcm dma\n");
 		return ret;
 	}
 
@@ -879,6 +879,6 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 module_platform_driver(stm32_sai_sub_driver);
 
 MODULE_DESCRIPTION("STM32 Soc SAI sub-block Interface");
-MODULE_AUTHOR("Olivier Moysan, <olivier.moysan@st.com>");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@st.com>");
 MODULE_ALIAS("platform:st,stm32-sai-sub");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
