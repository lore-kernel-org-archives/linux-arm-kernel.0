From: broonie@kernel.org (Mark Brown)
Date: Wed,  7 Nov 2018 15:01:19 +0000 (GMT)
Subject: Applied "spi: Kconfig: Enable McSPI driver for K3 platforms" to the
 spi tree
In-Reply-To: <20181107103926.32550-3-vigneshr@ti.com>
Message-ID: <20181107150119.6F3831124E14@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: Kconfig: Enable McSPI driver for K3 platforms

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 81df42d10457d3aef5321e9772c8eef173adf7f7 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Wed, 7 Nov 2018 16:09:26 +0530
Subject: [PATCH] spi: Kconfig: Enable McSPI driver for K3 platforms

Enable McSPI driver to be built for K3 platforms, to support McSPI on
AM654 SoC of K3 family.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 91d45c9ac439..b9be21cc07d2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
-- 
2.19.0.rc2
