From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 20 Dec 2013 12:36:56 +0200
Subject: [PATCH RFC v2 REPOST 0/8] Beaglebone-Black HDMI audio
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Message-ID: <cover.1387535299.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since the first RFC version of the patches:
- Drop out already applied: 
  ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE playback format
- Change sound node's compatible property
  form: "ti,am33xx-beaglebone-black" to "ti,am33xx-beaglebone-black-audio"
- Some minor style issue fixes from TI internal review

The patches have been rebased on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound topic/davinci

The associated dts change can be found here:
http://www.spinics.net/lists/linux-omap/msg101072.html

Best regards,
Jyri

Jyri Sarha (8):
  clk: add gpio controlled clock
  ASoC: davinci-evm: Add named clock reference to DT bindings
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: hdmi-codec: Add devicetree binding with documentation
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  drm/tilcdc: Add I2C HDMI audio config for tda998x
  ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc and TDA998X HDMI
    support
  ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
    support

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |   13 +-
 Documentation/devicetree/bindings/sound/hdmi.txt   |   17 ++
 arch/arm/configs/omap2plus_defconfig               |    5 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  210 ++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 include/linux/clk-provider.h                       |   25 +++
 sound/soc/codecs/hdmi.c                            |   10 +
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |  227 +++++++++++++++++++-
 12 files changed, 559 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5
