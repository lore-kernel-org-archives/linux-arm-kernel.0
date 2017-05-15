From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 May 2017 17:04:35 +0900
Subject: Applied "spi: bcm63xx-hsspi: Export OF device ID table as module
 aliases" to the spi tree
In-Reply-To: <20170501201338.5368-1-andresgalacho@gmail.com>
Message-ID: <E1dAAzb-0002el-44@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: bcm63xx-hsspi: Export OF device ID table as module aliases

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

>From 0b85a84217903e6d24342cc50bc5a685f8355711 Mon Sep 17 00:00:00 2001
From: Andres Galacho <andresgalacho@gmail.com>
Date: Mon, 1 May 2017 16:13:38 -0400
Subject: [PATCH] spi: bcm63xx-hsspi: Export OF device ID table as module
 aliases

The device table is required to load modules based on
modaliases. After adding MODULE_DEVICE_TABLE, below entries
for example will be added to module.alias:
alias:          of:N*T*Cbrcm,bcm6328-hsspiC*
alias:          of:N*T*Cbrcm,bcm6328-hsspi

Signed-off-by: Andres Galacho <andresgalacho@gmail.com>
Acked-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 5514cd02e93a..4da2d4a524ca 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -484,6 +484,7 @@ static const struct of_device_id bcm63xx_hsspi_of_match[] = {
 	{ .compatible = "brcm,bcm6328-hsspi", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_hsspi_of_match);
 
 static struct platform_driver bcm63xx_hsspi_driver = {
 	.driver = {
-- 
2.11.0
