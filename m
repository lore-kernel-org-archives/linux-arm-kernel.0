From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Nov 2016 13:10:28 +0000
Subject: Applied "spi: atmel: trivial: move info banner to latest probe
 action" to the spi tree
In-Reply-To: <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <E1cAGGq-0005HG-GG@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: trivial: move info banner to latest probe action

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From ce24a513fb142e855b4aa77f91334c2f203c0d99 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 24 Nov 2016 12:24:57 +0100
Subject: [PATCH] spi: atmel: trivial: move info banner to latest probe action

The info banner is here to tell that everything went well, so place
it at the very end of the probe function.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b2931493cab2..a9ae1836e1e2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1654,10 +1654,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		spi_writel(as, CR, SPI_BIT(FIFOEN));
 	}
 
-	/* go! */
-	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
-			(unsigned long)regs->start, irq);
-
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -1667,6 +1663,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_free_dma;
 
+	/* go! */
+	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
+			(unsigned long)regs->start, irq);
+
 	return 0;
 
 out_free_dma:
-- 
2.10.2
