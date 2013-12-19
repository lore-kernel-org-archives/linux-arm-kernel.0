From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Dec 2013 15:55:01 +0000
Subject: [PATCH 04/11] ASoC: Ux500: Match platform by device node when booting
 Device Tree
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1387468508-12286-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're getting closer to fully enabling the Ux500 ASoC driver for Device
Tree. When we switch over from using AUXDATA we'll need to match platform
by only Device Tree nodes. In this patch we NULL out the platform_name,
and supply nodes for each platform device.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/mop500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 178d1ba..b3b66aa 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -91,6 +91,8 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpu_of_node = msp_np[i];
 		mop500_dai_links[i].cpu_dai_name = NULL;
+		mop500_dai_links[i].platform_of_node = msp_np[i];
+		mop500_dai_links[i].platform_name = NULL;
 		mop500_dai_links[i].codec_of_node = codec_np;
 		mop500_dai_links[i].codec_name = NULL;
 	}
-- 
1.8.3.2
