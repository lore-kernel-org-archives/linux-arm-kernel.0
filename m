From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:58 +0100
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for Spring.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 sound/soc/samsung/Kconfig | 1 +
 sound/soc/samsung/snow.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 3cebf6ca03df..222181655e4f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -214,6 +214,7 @@ config SND_SOC_LITTLEMILL
 config SND_SOC_SNOW
 	tristate "Audio support for Google Snow boards"
 	depends on SND_SOC_SAMSUNG && I2C
+	select SND_SOC_MAX98088
 	select SND_SOC_MAX98090
 	select SND_SOC_MAX98095
 	select SND_SAMSUNG_I2S
diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 7651dc924161..89d7e39b206e 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -105,6 +105,7 @@ static int snow_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snow_of_match[] = {
+	{ .compatible = "google,snow-audio-max98089", },
 	{ .compatible = "google,snow-audio-max98090", },
 	{ .compatible = "google,snow-audio-max98091", },
 	{ .compatible = "google,snow-audio-max98095", },
-- 
2.1.4
