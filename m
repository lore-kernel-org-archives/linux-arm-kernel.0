From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 30 Jan 2014 18:14:04 +0100
Subject: [PATCH 0/7] Audio support for Armada 370 DB
Message-ID: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches enable audio support on the Marvell Armada 370
Development Board. Since both the I2S controller on the SoC side and
the I2C audio codec are already supported by the kernel, the amount of
work is fairly limited.

Also, since the DT bindings that allows to replace the ASoC board
driver are still being ironed out, I'm proposing to add an old-style
ASoC board driver for now.

This set of patches only provide support for the analog output and
input, I am waiting for the optical cable to arrive to get the digital
input and output to work.

Patches 1 to 3 are to be taken by the ASoC maintainer, while patches 4
to 7 are to be taken by the mvebu maintainers.

Note that the audio support for Armada 370 also needs a fix to the
CS42L51, which is being discussed with the author of the change that
apparently introduced the problem (see discussion at
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071916.html).

Thanks,

Thomas

Thomas Petazzoni (7):
  sound: codec: add Device Tree binding to cs42l51
  sound: soc: enable Kirkwood driver for mvebu platforms
  sound: soc: add ASoC board driver for Armada 370 DB
  ARM: mvebu: add audio I2S controller to Armada 370 Device Tree
  ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
  ARM: mvebu: add audio support to Armada 370 DB
  ARM: mvebu: enable audio options in mvebu_defconfig

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/sound/mvebu-audio.txt      |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  46 +++++++
 arch/arm/boot/dts/armada-370.dtsi                  |  29 +++++
 arch/arm/configs/mvebu_defconfig                   |   5 +
 sound/soc/codecs/cs42l51.c                         |   7 +
 sound/soc/kirkwood/Kconfig                         |  10 +-
 sound/soc/kirkwood/Makefile                        |   2 +
 sound/soc/kirkwood/armada-370-db.c                 | 144 +++++++++++++++++++++
 sound/soc/kirkwood/kirkwood-i2s.c                  |   1 +
 10 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/kirkwood/armada-370-db.c

-- 
1.8.3.2
