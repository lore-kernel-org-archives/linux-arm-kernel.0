From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:29:28 +0530
Subject: [PATCH 5/7] ASoC: rockchip: make snd_soc_ops const
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502902770-3758-6-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index dbc53e4..42227b0 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -147,7 +147,7 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 	return 0;
 }
 
-static struct snd_soc_ops rk_ops = {
+static const struct snd_soc_ops rk_ops = {
 	.hw_params = rk_hw_params,
 };
 
-- 
1.9.1
