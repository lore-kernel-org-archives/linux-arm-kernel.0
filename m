From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Mar 2018 01:57:51 +0000 (GMT)
Subject: Applied "ASoC: rockchip: Fix dai_name for HDMI codec" to the asoc tree
In-Reply-To: <20180320160332.13212-2-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180321015751.9D29644007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Fix dai_name for HDMI codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a5ad3b4b240b0335f9ea7d474efa79ba8463ade7 Mon Sep 17 00:00:00 2001
From: Ezequiel Garcia <ezequiel@collabora.co.uk>
Date: Tue, 20 Mar 2018 13:03:30 -0300
Subject: [PATCH] ASoC: rockchip: Fix dai_name for HDMI codec

Commit 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
changed the dai_name for the HDMI Codec, breaking the rk3288_hdmi_analog
driver, which fails to register with a:

  rk3288-snd-hdmi-analog sound: ASoC: CODEC DAI hdmi-hifi.0 not registered

This commit fixes the dai_name, fixing the issue.

Fixes: 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
