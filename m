From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 20 Mar 2018 13:03:30 -0300
Subject: [PATCH 1/3] ASoC: rockchip: Fix dai_name for HDMI codec
In-Reply-To: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180320160332.13212-2-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Commit 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
changed the dai_name for the HDMI Codec, breaking the rk3288_hdmi_analog
driver, which fails to register with a:

  rk3288-snd-hdmi-analog sound: ASoC: CODEC DAI hdmi-hifi.0 not registered

This commit fixes the dai_name, fixing the issue.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Fixes: 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index fa44e3901336..929b3fe289b0 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -155,7 +155,7 @@ static struct snd_soc_dai_link_component rk_codecs[] = {
 	{ },
 	{
 		.name = "hdmi-audio-codec.2.auto",
-		.dai_name = "hdmi-hifi.0",
+		.dai_name = "i2s-hifi",
 	},
 };
 
-- 
2.16.2
