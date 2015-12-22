From: songjun.wu@atmel.com (Songjun Wu)
Date: Tue, 22 Dec 2015 14:06:42 +0800
Subject: [PATCH] ASoC: atmel_wm8904: add snd_soc_pm_ops
Message-ID: <1450764402-15669-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the audio play can not be resumed after it is
suspended. Add snd_soc_pm_ops to execute power management
operations, then this issue is fixed.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 sound/soc/atmel/atmel_wm8904.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 1933bcd..fdd28ed 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -183,6 +183,7 @@ static struct platform_driver atmel_asoc_wm8904_driver = {
 	.driver = {
 		.name = "atmel-wm8904-audio",
 		.of_match_table = of_match_ptr(atmel_asoc_wm8904_dt_ids),
+		.pm		= &snd_soc_pm_ops,
 	},
 	.probe = atmel_asoc_wm8904_probe,
 	.remove = atmel_asoc_wm8904_remove,
-- 
1.7.9.5
