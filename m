From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 10 Sep 2012 13:46:23 +0300
Subject: [PATCH v4 05/14] MFD: twl4030-audio: Get audio MCLK via twl-core API
 instead of pdata
In-Reply-To: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347273992-9107-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

twl-core has API to get the boot time configured HFCLK rate which has the
same rate as the audio MCLK.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl4030-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index ca2d669..a48bf3a 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -175,7 +175,7 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&audio->mutex);
-	audio->audio_mclk = pdata->audio_mclk;
+	audio->audio_mclk = twl_get_hfclk_rate();
 
 	/* Configure APLL_INFREQ and disable APLL if enabled */
 	switch (audio->audio_mclk) {
-- 
1.7.12
