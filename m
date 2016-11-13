From: broonie@kernel.org (Mark Brown)
Date: Sun, 13 Nov 2016 09:27:00 +0000
Subject: Applied "ASoC: mioa701_wm9713: add missing white space in dev_err
 message" to the regulator tree
In-Reply-To: <20161112163025.4801-1-colin.king@canonical.com>
Message-ID: <E1c5r40-0006gC-2d@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mioa701_wm9713: add missing white space in dev_err message

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 28cbed38973cd458e4cdba1df9a240ce739da841 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 12 Nov 2016 16:30:25 +0000
Subject: [PATCH] ASoC: mioa701_wm9713: add missing white space in dev_err
 message

There is a missing whitespace in the dev_err message between
"will" and "lead".  Add the whitespace.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mioa701_wm9713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index d1661fa6ee08..0fe0abec8fc4 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -187,7 +187,7 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
 	mioa701.dev = &pdev->dev;
 	rc = devm_snd_soc_register_card(&pdev->dev, &mioa701);
 	if (!rc)
-		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
+		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will "
 			 "lead to overheating and possible destruction of your device."
 			 " Do not use without a good knowledge of mio's board design!\n");
 	return rc;
-- 
2.10.2
