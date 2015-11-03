From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 09:33:56 +0800
Subject: [PATCH v1 3/5] ASoC: rockchip-rt5645: Allow more sample rates
In-Reply-To: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446514438-13922-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RT5645 audio codec support sample rates from 8 to 96 kHz
as the dai claim.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1: None

 sound/soc/rockchip/rockchip_rt5645.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 68c62e4..edff07f 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -79,11 +79,16 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 24000:
+	case 32000:
 	case 48000:
 	case 96000:
 		mclk = 12288000;
 		break;
+	case 11025:
+	case 22050:
 	case 44100:
+	case 88200:
 		mclk = 11289600;
 		break;
 	default:
-- 
1.9.1
