From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Feb 2017 16:26:10 -0800
Subject: Applied "spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking
 compilation" to the spi tree
In-Reply-To: <20170221233040.24241-1-jonas.gorski@gmail.com>
Message-ID: <E1cgKl0-0005WH-Rm@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking compilation

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

>From ccd0657c33b2c3701c5b14725284b7e671d3fb93 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 22 Feb 2017 00:30:40 +0100
Subject: [PATCH] spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking
 compilation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix compilation by renaming argument dev to spi as expected by the code.

Fixes the following error:

drivers/spi/spi-bcm63xx.c: In function ???bcm63xx_spi_max_length???:
drivers/spi/spi-bcm63xx.c:434:50: error: ???spi??? undeclared (first use in this function)
  struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
                                                  ^~~

Fixes: 0135c03df914 ("spi/bcm63xx: make spi subsystem aware of message size limits")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 325131370941..247f71b02235 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -429,7 +429,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static size_t bcm63xx_spi_max_length(struct spi_device *dev)
+static size_t bcm63xx_spi_max_length(struct spi_device *spi)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 
-- 
2.11.0
