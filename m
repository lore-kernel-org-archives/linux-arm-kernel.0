From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jul 2018 12:03:01 +0100 (BST)
Subject: Applied "ASoC: uniphier: change functions to static" to the asoc tree
In-Reply-To: <20180727023744.7865-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180730110301.72F1F1124216@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: uniphier: change functions to static

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

>From d8504acca759ae672c6d34d49a33d54ace094cbb Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 27 Jul 2018 11:37:44 +0900
Subject: [PATCH] ASoC: uniphier: change functions to static

This patch changes some functions that are not used by other objects
to static.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 6 +++---
 sound/soc/uniphier/aio.h      | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 8b09bbb0f8d0..9bcba06ba52e 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -327,7 +327,7 @@ static int aio_port_set_ch(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
+static int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -446,7 +446,7 @@ int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_fmt(struct uniphier_aio_sub *sub)
+static int aio_port_set_fmt(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -511,7 +511,7 @@ int aio_port_set_fmt(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_clk(struct uniphier_aio_sub *sub)
+static int aio_port_set_clk(struct uniphier_aio_sub *sub)
 {
 	struct uniphier_aio_chip *chip = sub->aio->chip;
 	struct device *dev = &sub->aio->chip->pdev->dev;
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 23a5c3c68658..ca6ccbae0ee8 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -325,9 +325,6 @@ int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
 void aio_chip_init(struct uniphier_aio_chip *chip);
 int aio_init(struct uniphier_aio_sub *sub);
 void aio_port_reset(struct uniphier_aio_sub *sub);
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate);
-int aio_port_set_fmt(struct uniphier_aio_sub *sub);
-int aio_port_set_clk(struct uniphier_aio_sub *sub);
 int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 		       const struct snd_pcm_hw_params *params);
 void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
-- 
2.18.0
