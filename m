From: broonie@kernel.org (Mark Brown)
Date: Fri, 01 Dec 2017 13:43:57 +0000
Subject: Applied "ASoC: intel: mfld: Handle return value of platform_get_irq"
 to the asoc tree
In-Reply-To: <3c83856bd9f1f23d1e0f5e8753d3998ae4785e37.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <E1eKlbh-0001GI-3V@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: intel: mfld: Handle return value of platform_get_irq

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

>From 00a5cc096774fbc9ac979765fa820e7c8d9121c4 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 29 Nov 2017 21:47:14 +0530
Subject: [PATCH] ASoC: intel: mfld: Handle return value of platform_get_irq

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/mfld_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acfb4aae..7cb44fdde1ee 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -372,6 +372,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 	/* retrive the irq number */
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq < 0 ? irq : -ENODEV;
 
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
-- 
2.15.0
