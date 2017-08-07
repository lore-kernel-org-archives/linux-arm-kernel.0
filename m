From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 12:52:07 +0100
Subject: Applied "ASoC: mediatek: Fix an error checking code" to the asoc tree
In-Reply-To: <20170807002315.3512-1-christophe.jaillet@wanadoo.fr>
Message-ID: <E1degZr-0006pT-7Y@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: Fix an error checking code

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

>From 8d7313bfb1bb7d71a6ebc503215e4fb4a8964741 Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Mon, 7 Aug 2017 02:23:15 +0200
Subject: [PATCH] ASoC: mediatek: Fix an error checking code

Check the value returned by 'devm_clk_get()' instead of the clock
identifier which can never be an ERR code.

Fixes: d6f3710a56e1 ("ASoC: mediatek: add structure define and clock control for 2701")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index b815ecc6bbf6..affa7fb25dd9 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -75,7 +75,7 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 
 	for (i = 0; i < MT2701_CLOCK_NUM; i++) {
 		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
-		if (IS_ERR(aud_clks[i])) {
+		if (IS_ERR(afe_priv->clocks[i])) {
 			dev_warn(afe->dev, "%s devm_clk_get %s fail\n",
 				 __func__, aud_clks[i]);
 			return PTR_ERR(aud_clks[i]);
-- 
2.13.3
