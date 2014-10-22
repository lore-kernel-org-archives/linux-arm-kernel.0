From: jay.xu@rock-chips.com (Jianqun)
Date: Wed, 22 Oct 2014 08:40:56 +0800
Subject: [PATCH] ASoC: rockchip-i2s: add rockchip-max98090 driver support
In-Reply-To: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1413938456-30468-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add support for rockchip board with max98090 codec.
It also needs sound node in dt file.

Tested on rockchip board based on rk3288.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
change since v1:
-Just make the max98090 driver directly selectable, suggested by Lars

 sound/soc/rockchip/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 78fc159..230b0e9 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -9,3 +9,15 @@ config SND_SOC_ROCKCHIP
 
 config SND_SOC_ROCKCHIP_I2S
 	tristate
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	help
+	  Say Y or M if you want to add support for I2S driver for Rockchip
+	  I2S device.
+
+config SND_SOC_MAX98090
+	tristate "ASoC support max98090 device driver"
+	depends on I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	help
+	  Say Y or M here if you want to add support for Rockchio board using
+	  a max98090 codec.
-- 
1.9.1
