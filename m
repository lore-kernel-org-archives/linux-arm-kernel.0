From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 24 Nov 2016 12:24:57 +0100
Subject: [PATCH 1/5] spi: atmel: trivial: move info banner to latest probe
 action
In-Reply-To: <cover.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The info banner is here to tell that everything went well, so place
it at the very end of the probe function.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index a038ffe90766..68e22bf94647 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1658,10 +1658,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		spi_writel(as, CR, SPI_BIT(FIFOEN));
 	}
 
-	/* go! */
-	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
-			(unsigned long)regs->start, irq);
-
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -1671,6 +1667,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_free_dma;
 
+	/* go! */
+	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
+			(unsigned long)regs->start, irq);
+
 	return 0;
 
 out_free_dma:
-- 
2.9.0
