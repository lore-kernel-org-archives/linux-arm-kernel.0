From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Mar 2018 01:57:29 +0000 (GMT)
Subject: Applied "ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs" to
 the asoc tree
In-Reply-To: <20180320160332.13212-3-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180321015729.0B1B044007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

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

>From b1d0db067fbe2598d62b248beea5d705a0ea7642 Mon Sep 17 00:00:00 2001
From: Ezequiel Garcia <ezequiel@collabora.co.uk>
Date: Tue, 20 Mar 2018 13:03:31 -0300
Subject: [PATCH] ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

The driver does not select all the codec drivers that needs.
Fix it by selecting the analog and HDMI codecs.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b0825370d262..957046ac6c8c 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -56,6 +56,9 @@ config SND_SOC_RK3288_HDMI_ANALOG
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_ES8328_I2C
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select DRM_DW_HDMI_I2S_AUDIO if DRM_DW_HDMI
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  RK3288 boards using an analog output and the built-in HDMI audio.
-- 
2.16.2
