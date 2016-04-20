From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Apr 2016 17:19:56 +0100
Subject: Applied "ASoC: ak4642: Remove CLK_IS_ROOT" to the asoc tree
In-Reply-To: <1461114304-10495-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <E1asur6-0006ze-I5@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: ak4642: Remove CLK_IS_ROOT

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

>From b6bf3289bc3c1d8df9f37c2f4f8450cc677fb286 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 19 Apr 2016 18:05:04 -0700
Subject: [PATCH] ASoC: ak4642: Remove CLK_IS_ROOT

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4642.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index cda27c22812a..1ee8506c06c7 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -608,9 +608,7 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 
 	of_property_read_string(np, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name,
-				      (parent_clk_name) ? 0 : CLK_IS_ROOT,
-				      rate);
+	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name, 0, rate);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 
-- 
2.8.0.rc3
