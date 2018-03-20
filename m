From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 20 Mar 2018 13:03:31 -0300
Subject: [PATCH 2/3] ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
In-Reply-To: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180320160332.13212-3-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

The driver does not select all the codec drivers that needs.
Fix it by selecting the analog and HDMI codecs.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
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
