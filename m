From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Aug 2017 16:22:44 +0100
Subject: Applied "ASoC: rockchip: constify snd_soc_ops structures" to the asoc
 tree
In-Reply-To: <20170830095814.2030-1-jeffy.chen@rock-chips.com>
Message-ID: <E1dn4pI-0003SU-7O@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: constify snd_soc_ops structures

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1fe165b7e9c3e1b1cfa98310979db0814c7445ea Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Wed, 30 Aug 2017 17:58:14 +0800
Subject: [PATCH] ASoC: rockchip: constify snd_soc_ops structures

Add const to dp/dmic snd_soc_ops.

Fixes: 626d84db64d7 (ASoC: rockchip: Add support for DMIC codec)
Fixes: 3313faf1053e (ASoC: rockchip: Add support for DP codec)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 5ab25962cabd..0513fe480353 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -301,11 +301,11 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_cdndp_ops = {
+static const struct snd_soc_ops rockchip_sound_cdndp_ops = {
 	.hw_params = rockchip_sound_cdndp_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_dmic_ops = {
+static const struct snd_soc_ops rockchip_sound_dmic_ops = {
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
 
-- 
2.14.1
