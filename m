From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 15:15:18 +0000
Subject: [PATCH -next] ASoC: rk3399_gru_sound: Fix non static symbol warning
Message-ID: <1476717318-12684-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

sound/soc/rockchip/rk3399_gru_sound.c:41:14: warning:
 symbol 'rt5514_dmic_delay' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9ed735a..0cbd235 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,7 +38,7 @@
 
 #define SOUND_FS	256
 
-unsigned int rt5514_dmic_delay;
+static unsigned int rt5514_dmic_delay;
 
 static struct snd_soc_jack rockchip_sound_jack;
