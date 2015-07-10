From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Jul 2015 10:39:17 +0200
Subject: [PATCH] ARM: ep93xx: simone: enable DMA on the SPI host
Message-ID: <1436517557-11725-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI host on the SIM.ONE is used for the MMC/SD card and
will badly need this turbo boost.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/simone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 3c950f5864f3..d0938a219443 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -169,6 +169,7 @@ static struct spi_board_info simone_spi_devices[] __initdata = {
 
 static struct ep93xx_spi_info simone_spi_info __initdata = {
 	.num_chipselect	= ARRAY_SIZE(simone_spi_devices),
+	.use_dma = 1,
 };
 
 static struct i2c_gpio_platform_data __initdata simone_i2c_gpio_data = {
-- 
2.4.3
