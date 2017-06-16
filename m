From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 18:50:03 +0100
Subject: Applied "ASoC: stm32: sai: remove spurious trace" to the asoc tree
In-Reply-To: <1497615334-7156-5-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dLvNj-0005fS-1u@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: remove spurious trace

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

>From e0588cb6e3fee423553c34b10e9c83b6adb7c16e Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:15:31 +0200
Subject: [PATCH] ASoC: stm32: sai: remove spurious trace

Remove spurious trace in sai driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d7aeed3ec3c8..24b8874cfe5f 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -761,9 +761,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return -ENODEV;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	dev_err(&pdev->dev, "res %pr\n", res);
-
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.11.0
