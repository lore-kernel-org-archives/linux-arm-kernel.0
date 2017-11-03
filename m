From: broonie@kernel.org (Mark Brown)
Date: Fri, 03 Nov 2017 18:50:58 +0000
Subject: Applied "spi: s3c64xx: remove redundant pointer sci" to the spi tree
In-Reply-To: <20171103133525.8173-1-colin.king@canonical.com>
Message-ID: <E1eAh3S-0005u1-W6@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: remove redundant pointer sci

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

>From 4132b8b9107badf75bf30c8b4b3ac2cebd03389d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 3 Nov 2017 13:35:25 +0000
Subject: [PATCH] spi: s3c64xx: remove redundant pointer sci

The pointer sci is assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/spi/spi-s3c64xx.c:791:2: warning: Value stored to 'sci' is
never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b392cca8fa4f..de7df20f8712 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -752,7 +752,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_info *sci;
 	int err;
 
 	sdd = spi_master_get_devdata(spi->master);
@@ -788,8 +787,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, cs);
 	}
 
-	sci = sdd->cntrlr_info;
-
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
 	/* Check if we can provide the requested rate */
-- 
2.15.0
