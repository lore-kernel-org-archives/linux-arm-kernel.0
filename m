From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 17 Jun 2017 22:09:32 +0800
Subject: [PATCH 0/2] Add ZTE ZTE zx-aud96p22 audio codec driver
Message-ID: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

This is a pick-up of Baoyou's zx-aud96p22 audio codec driver
submission [1], with quite some significant rework as below.

 - Instead of hard-coding the GPIO used to control external amplifier,
   use generic devm_gpiod_get_optional() call to retrieve the GPIO
   defined in device tree.
 - Rather than directly using I2C bus calls, use REGMAP_I2C interface
   which is more common for accessing codec register via I2C bus.
 - Use snd_kcontrol_new infrastructural for Volume and Mute control.
 - Use DAPM widget and route for various power bits control.
 - A lot of code cleanups

[1] https://lkml.org/lkml/2017/2/15/170

Baoyou Xie (2):
  ASoC: add bindings for ZTE zx-aud96p22 audio codec
  ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver

 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  |  28 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/zx_aud96p22.c                     | 425 +++++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
 create mode 100644 sound/soc/codecs/zx_aud96p22.c

-- 
1.9.1
