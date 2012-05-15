From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 13:53:48 +0200
Subject: [PATCH 0/4] MC13783 sound support
Message-ID: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patchset enables sound support on boards with mc13783 codec.
The first patch adds the necessary modification to the MFD driver.
The second patch adds the codec driver. It's Sascha's code ported
to the current kernel with DAPM.
The third patch adds a generic SoC platform driver for imx boards
with mc13783 codecs.
The last patch enable the sound on mx31moboard boards.
I will post a similar patch for mx31pdk_3ds as soon as I figure out why
it hangs early at boot with the latest kernel (unrelated to this patchset).

It is based on 3.4-rc4 with asoc-3.5 and the sdma channel 0 mutex to
spinlock fix.

Philippe R?tornaz (4):
  mc13xxx: add codec platform data
  ASoC: Add mc13783 codec
  ASoC: add imx-mc13783 sound support
  mx31moboard: Add sound support

 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c |   20 +-
 drivers/mfd/mc13xxx-core.c           |    3 +-
 include/linux/mfd/mc13xxx.h          |   11 +
 sound/soc/codecs/Kconfig             |    4 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/mc13783.c           |  800 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h           |   28 ++
 sound/soc/fsl/Kconfig                |    8 +
 sound/soc/fsl/Makefile               |    2 +
 sound/soc/fsl/imx-mc13783.c          |  163 +++++++
 11 files changed, 1040 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/fsl/imx-mc13783.c
