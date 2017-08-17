From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:13:05 +0100
Subject: Applied "ASoC: rockchip: make snd_soc_ops const" to the asoc tree
In-Reply-To: <1502902770-3758-6-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOLx-0008NC-8r@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: make snd_soc_ops const

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

>From c12a4a40b4fdaefa6c2578e86d277410e1a9cea1 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:28 +0530
Subject: [PATCH] ASoC: rockchip: make snd_soc_ops const

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index dbc53e48c52c..42227b0f66ac 100644
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
2.13.3
