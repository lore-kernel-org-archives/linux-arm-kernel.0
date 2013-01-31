From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 31 Jan 2013 11:53:39 +0800
Subject: [PATCH 3/4] ASoC: atmel_ssc_dai: correct sequence when unload
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1359604420-15171-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

correct the sequence when unload this module

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 2763aea..1fab8d5 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -780,8 +780,8 @@ void atmel_ssc_put_audio(int ssc_id)
 {
 	struct ssc_device *ssc = ssc_info[ssc_id].ssc;
 
-	ssc_free(ssc);
 	asoc_ssc_exit(&ssc->pdev->dev);
+	ssc_free(ssc);
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_put_audio);
 
-- 
1.7.9.5
