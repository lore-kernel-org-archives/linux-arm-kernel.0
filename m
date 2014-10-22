From: jay.xu@rock-chips.com (Jianqun)
Date: Wed, 22 Oct 2014 10:59:59 +0800
Subject: [PATCH v3] ASoC: rockchip-i2s: add MAX98090 support to Kconfig
In-Reply-To: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1413946799-20834-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SND_SOC_MAX98090 to Kconfig of rockchip ASoC, to support
rockchip board using a max98090 codec.

Tested on rockchip board based on rk3288.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
changes since v1:
--make the max98090 driver directly selectable, suggested by Lars

changes since v2:
--modify tristate infomation for SND_SOC_ROCKCHIP
--make SND_SOC_MAX98090 not depends on SND_SOC_ROCKCHIP

 sound/soc/rockchip/Kconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 78fc159..236500e 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -1,5 +1,5 @@
 config SND_SOC_ROCKCHIP
-	tristate "ASoC support for Rockchip"
+	tristate "SoC Audio for the Rockchip System-on-Chip"
 	depends on COMPILE_TEST || ARCH_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
@@ -8,4 +8,14 @@ config SND_SOC_ROCKCHIP
 	  select the audio interfaces to support below.
 
 config SND_SOC_ROCKCHIP_I2S
-	tristate
+	tristate "ASoC support for Rockchip I2S driver"
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	help
+	  Say Y or M if you want to add support for I2S driver for Rockchip
+	  I2S device.
+
+config SND_SOC_MAX98090
+	tristate "ASoC support for max98090 driver"
+	depends on I2C && GPIOLIB
+	help
+	  Say Y or M here if you want to add support for max98090 codec.
-- 
1.9.1
