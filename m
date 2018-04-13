From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Apr 2018 12:24:52 +0100
Subject: Applied "ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" ->
 "Stopping"" to the asoc tree
In-Reply-To: <20180330154420.6903-1-colin.king@canonical.com>
Message-ID: <E1f6wp2-0000Mn-DN@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" -> "Stopping"

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

>From 78a7d414d5a8e3ea7bc5a636311cfb7ce593ce37 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 30 Mar 2018 16:44:20 +0100
Subject: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" ->
 "Stopping"

Trivial fix to spelling mistake in pr_debug message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..1c7af0ca98ec 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			printk(KERN_WARNING
 					"atmel_ssc_dai: request_irq failure\n");
-			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			pr_debug("Atmel_ssc_dai: Stopping clock\n");
 			clk_disable(ssc_p->ssc->clk);
 			return ret;
 		}
-- 
2.17.0
