From: jay.xu@rock-chips.com (Jianqun)
Date: Sat,  1 Nov 2014 10:58:18 +0800
Subject: [PATCH v2] ASoC: rockchip: i2s: add text after tristate for
 SND_SOC_ROCKCHIP_I2S
In-Reply-To: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1414810698-5609-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For SND_SOC_ROCKCHIP_I2S, adding some text after the
tristate to make this directly user selectable.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
changes since v1:
-to make this directlyuser selectable by adding some text after
the tristate as well as the rest, suggested by Mark
-to use the existing MAX98090 entry, not duplicate it, so remove
related codes, suggested by Mark

 sound/soc/rockchip/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 78fc159..b1fc0ca 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -8,4 +8,9 @@ config SND_SOC_ROCKCHIP
 	  select the audio interfaces to support below.
 
 config SND_SOC_ROCKCHIP_I2S
-	tristate
+	tristate "Rockchip I2S Device Driver"
+	depends on CLKDEV_LOOKUP
+	help
+	  Say Y or M if you want to add support for I2S driver for
+	  Rockchip I2S device. The device supports upto maximum of
+	  8 channels each for play and record.
-- 
1.9.1
