From: broonie@kernel.org (Mark Brown)
Date: Wed, 09 Nov 2016 14:59:30 +0000
Subject: Applied "ASoC: wm8978: Adjust clock indices so that simple card
 works" to the asoc tree
In-Reply-To: <3d9c794b19e99745f0a98412c4cf8dcf26d728d4.1478524066.git-series.maxime.ripard@free-electrons.com>
Message-ID: <E1c4ULa-0002fj-Mt@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: wm8978: Adjust clock indices so that simple card works

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

>From fbd972d7f4a60677f6fbe558dc23e4029dc2d45d Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 7 Nov 2016 14:08:20 +0100
Subject: [PATCH] ASoC: wm8978: Adjust clock indices so that simple card works

Using simple-card with the wm8978 doesn't work because simple card calls
set_sysclk on the clock index 0, which is not the MCLK in the WM8978.

Adjust the clock definition so that the clock 0 is the MCLK.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8978.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
index 6ae43495b7cf..0dcf6868dff6 100644
--- a/sound/soc/codecs/wm8978.h
+++ b/sound/soc/codecs/wm8978.h
@@ -78,8 +78,8 @@ enum wm8978_clk_id {
 };
 
 enum wm8978_sysclk_src {
+	WM8978_MCLK = 0,
 	WM8978_PLL,
-	WM8978_MCLK
 };
 
 #endif	/* __WM8978_H__ */
-- 
2.10.2
