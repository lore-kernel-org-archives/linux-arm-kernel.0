From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:32:07 +0100
Subject: Applied "ASoC: mediatek: mt2701: fix non static symbol warning" to
 the asoc tree
In-Reply-To: <1467985293-9041-1-git-send-email-weiyj_lk@163.com>
Message-ID: <E1bNjYV-0001SJ-C4@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: mt2701: fix non static symbol warning

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

>From 25d01dc67894de03de463727633e72e1727b4f6d Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date: Fri, 8 Jul 2016 13:47:01 +0000
Subject: [PATCH] ASoC: mediatek: mt2701: fix non static symbol warning

Fixes the following sparse warning:

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:72:5: warning:
 symbol 'mt2701_dai_num_to_i2s' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 15522c08a967..34a6123480d3 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -69,7 +69,7 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
 	{ .rate = 352800, .regvalue = 24 },
 };
 
-int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
+static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
 {
 	int val = num - MT2701_IO_I2S;
 
-- 
2.8.1
