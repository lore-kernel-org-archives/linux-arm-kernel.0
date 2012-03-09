From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri,  9 Mar 2012 15:55:12 +0100
Subject: [PATCH 0/4] mc13783 sound support
Message-ID: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This is patchset enable sound support on boards with mc13783 codec.
The first patch adds the codec driver. It's Sascha's code ported to the
current kernel with some minors additions.
The second patch adds a generic SoC platform driver for imx3 boards with
mc13783 codecs.
The last two patches enable the sound on the mx31moboard boards and on 
mx31pdk_3ds boards.

This patchset has been tested on mx31moboard and mx31pdk_3ds.

It is based on a 3.3-rc6 kernel. I know there are some patches which change
how audmux is handled on i.Mx processor but they are not yet merged so
I prefer to post this patchset based on a known tree than to add another
dependency. If the audmux change is merged I will rebase this patchset.

Small note: If you want to test this, make sure you use redboot as bootloader
or that you have the patch i.MX 35/5 AIPS Setup applied.


Philippe R??tornaz (3):
  Add imx3sound sound support.
  mx31moboard: Add ssi configuration
  imx31pdk: Add sound support

Sascha Hauer (1):
  add a mc13783 codec driver

 arch/arm/mach-imx/Kconfig            |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c    |   40 ++-
 arch/arm/mach-imx/mach-mx31moboard.c |   37 ++-
 drivers/mfd/mc13xxx-core.c           |    3 +-
 include/linux/mfd/mc13xxx.h          |   11 +
 sound/soc/codecs/Kconfig             |    4 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/mc13783.c           | 1036 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h           |   30 +
 sound/soc/imx/Kconfig                |   10 +
 sound/soc/imx/Makefile               |    2 +
 sound/soc/imx/imx3sound-mc13783.c    |  141 +++++
 12 files changed, 1315 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/imx/imx3sound-mc13783.c
