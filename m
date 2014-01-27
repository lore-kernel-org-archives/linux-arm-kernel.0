From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 27 Jan 2014 10:04:40 +0100
Subject: [PATCH 0/4] add a TDA998x CODEC
Message-ID: <cover.1390813480.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TDA998x HDMI transmitter accepts audio input from either I2S or S/PDIF.

Theses inputs have different intrinsic constraints and these constraints
may be modified by the audio parameters of the connected video device.

The choice of I2S or S/PDIF may be the done by the user or by automatic
processing (DPCM?) at each audio starting time. This asks for a dynamic
audio input switch in the HDMI driver.

This patch series implements the TDA998x specific CODEC.
A simple function call mechanism is used for exchanges between the
CODEC and the HDMI driver.

Jean-Francois Moine (4):
  drm/i2c: tda998x: add a function for dynamic audio input switch
  ASoC: tda998x: add a codec driver for TDA998x
  ASoC: tda998x: add DT documentation
  ASoC: tda998x: adjust the audio hw parameters from EDID

 .../devicetree/bindings/sound/tda998x.txt          |  14 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  58 +++-
 include/drm/i2c/tda998x.h                          |   8 +-
 sound/soc/codecs/Kconfig                           |   7 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 304 +++++++++++++++++++++
 6 files changed, 390 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
1.8.5.3
