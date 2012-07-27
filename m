From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:45:48 +0100
Subject: [PATCH 04/18] ASoC: Ux500: Enable ux500 PCM driver for Device Tree
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343393162-11938-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simple patch ensures the PCM driver will be probed during
boot-up when Device Tree is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 1a04e24..557da2d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -304,10 +304,16 @@ static int __devinit ux500_pcm_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ux500_pcm_match[] = {
+       { .compatible = "stericsson,ux500-pcm", },
+       {},
+};
+
 static struct platform_driver ux500_pcm_driver = {
 	.driver = {
 		.name = "ux500-pcm",
 		.owner = THIS_MODULE,
+		.of_match_table = ux500_pcm_match,
 	},
 
 	.probe = ux500_pcm_drv_probe,
-- 
1.7.9.5
