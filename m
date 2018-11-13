From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Nov 2018 18:28:18 +0000 (GMT)
Subject: Applied "ASoC: rockchip: add missing slave_config setting for I2S" to
 the asoc tree
In-Reply-To: <20181110151844.21362-1-katsuhiro@katsuster.net>
Message-ID: <20181113182818.DDD95440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: add missing slave_config setting for I2S

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

>From 16a8ee4c80b45984b6de1f90a49edcf336b7c621 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Sun, 11 Nov 2018 00:18:44 +0900
Subject: [PATCH] ASoC: rockchip: add missing slave_config setting for I2S

This patch adds missing prepare_sleve_config that is needed for
setup the DMA slave channel for I2S.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
index 9e7b5fa4cf59..4ac78d7a4b2d 100644
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -33,6 +33,7 @@ static const struct snd_pcm_hardware snd_rockchip_hardware = {
 
 static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
 	.pcm_hardware = &snd_rockchip_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.prealloc_buffer_size = 32 * 1024,
 };
 
-- 
2.19.1
