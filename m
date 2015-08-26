From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 26 Aug 2015 11:20:44 +0800
Subject: [PATCH v2] ASoC: rockchip: fix a misjudgement by return
Message-ID: <1440559244-17634-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being careless, judge the return value of snd_soc_card_jack_new
is opposite, so it should be fixed.

---

Changes in v2:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Dylan Reid <dgreid@chromium.org>

 sound/soc/rockchip/rockchip_rt5645.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 3c6bb1e..adfe98c 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -118,7 +118,7 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				    &headset_jack, NULL, 0);
-	if (!ret) {
+	if (ret) {
 		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
 		return ret;
 	}
-- 
1.7.9.5
