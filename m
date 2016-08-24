From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 24 Aug 2016 10:57:20 -0700
Subject: [PATCH -next] sound: rockchip: fix build when SPI_MASTER is not
 enabled
Message-ID: <22fcb876-1a27-0ff4-3f18-5079281c247e@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix multiple build errors in sound/soc/rockchip/ drivers by
adding "depends on SPI_MASTER".

Fixes these build errors:
sound/built-in.o: In function `rt5514_spi_burst_read':
(.text+0x6c26c): undefined reference to `spi_sync'
sound/built-in.o: In function `rt5514_spi_burst_write':
(.text+0x6c96e): undefined reference to `spi_sync'
sound/built-in.o: In function `rockchip_sound_probe':
rk3399_gru_sound.c:(.text+0x9f579): undefined reference to `spi_bus_type'
sound/built-in.o: In function `rt5514_spi_driver_init':
rt5514-spi.c:(.init.text+0x983): undefined reference to `__spi_register_driver'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Heiko Stuebner <heiko@sntech.de>
Cc:	linux-arm-kernel at lists.infradead.org
Cc:	linux-rockchip at lists.infradead.org
---
 sound/soc/rockchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20160824.orig/sound/soc/rockchip/Kconfig
+++ linux-next-20160824/sound/soc/rockchip/Kconfig
@@ -45,6 +45,7 @@ config SND_SOC_ROCKCHIP_RT5645
 config SND_SOC_RK3399_GRU_SOUND
 	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SPI_MASTER
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5514
