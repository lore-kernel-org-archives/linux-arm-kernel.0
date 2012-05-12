From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 May 2012 10:17:28 +0800
Subject: [GIT PULL] Adopt pinctrl support for imx and mxs drivers
Message-ID: <20120512021726.GC17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This series adds dummy pinctrl states for imx and mxs platforms and
then adopts pinctrl support for some outstanding imx and mxs drivers.
The reason that the series mixes two sub-architectures patches is some
drivers are shared between two sub-architectures, so we need to handle
them as a whole.

I haven't got the acks from all subsystem maintainers. Considering
we are close to merge window now, and the change is quite simple while
mxs device tree series depends on it, I would like to send the pull
request right away and hopefully to get it expose on linux-next soon.
I copied subsystem maintainers here in case they see problem to have
their patches go through arm-soc.

It depends on pinctrl branch below.

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel (or for-next)

Per Linus, his devel branch is identify to for-next, and both branches
are stable (non-rebased).

Regards,
Shawn

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/pinctrl/for-3.5

Dong Aisheng (3):
      ARM: imx: enable pinctrl dummy states
      ARM: imx6q: switch to use pinctrl subsystem
      mmc: sdhci-imx-esdhc: adopt pinctrl support

Shawn Guo (14):
      ARM: mxs: enable pinctrl dummy states
      tty: serial: imx: adopt pinctrl support
      net: fec: adopt pinctrl support
      can: flexcan: adopt pinctrl support
      i2c: imx: adopt pinctrl support
      spi/imx: adopt pinctrl support
      serial: amba-pl011: adopt pinctrl support
      serial: mxs-auart: adopt pinctrl support
      mmc: mxs-mmc: adopt pinctrl support
      mtd: nand: gpmi: adopt pinctrl support
      i2c: mxs: adopt pinctrl support
      ASoC: mxs-saif: adopt pinctrl support
      video: mxsfb: adopt pinctrl support
      ARM: mxs: enable pinctrl support

 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-imx/Kconfig               |    2 ++
 arch/arm/mach-imx/imx51-dt.c            |    3 +++
 arch/arm/mach-imx/imx53-dt.c            |    3 +++
 arch/arm/mach-imx/mach-imx6q.c          |    7 +++++++
 arch/arm/mach-imx/mm-imx1.c             |    2 ++
 arch/arm/mach-imx/mm-imx21.c            |    2 ++
 arch/arm/mach-imx/mm-imx25.c            |    2 ++
 arch/arm/mach-imx/mm-imx27.c            |    2 ++
 arch/arm/mach-imx/mm-imx3.c             |    2 ++
 arch/arm/mach-imx/mm-imx5.c             |    2 ++
 arch/arm/mach-mxs/Kconfig               |    2 ++
 arch/arm/mach-mxs/include/mach/common.h |    2 ++
 arch/arm/mach-mxs/mach-apx4devkit.c     |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c         |    2 ++
 arch/arm/mach-mxs/mach-mx23evk.c        |    2 ++
 arch/arm/mach-mxs/mach-mx28evk.c        |    2 ++
 arch/arm/mach-mxs/mach-stmp378x_devb.c  |    2 ++
 arch/arm/mach-mxs/mach-tx28.c           |    2 ++
 arch/arm/mach-mxs/mm.c                  |   11 +++++++++++
 drivers/i2c/busses/i2c-imx.c            |    8 ++++++++
 drivers/i2c/busses/i2c-mxs.c            |    6 ++++++
 drivers/mmc/host/mxs-mmc.c              |    8 ++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c      |    9 +++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c  |    9 +++++++++
 drivers/net/can/flexcan.c               |    6 ++++++
 drivers/net/ethernet/freescale/fec.c    |    9 +++++++++
 drivers/spi/spi-imx.c                   |    8 ++++++++
 drivers/tty/serial/amba-pl011.c         |    8 ++++++++
 drivers/tty/serial/imx.c                |    8 ++++++++
 drivers/tty/serial/mxs-auart.c          |    8 ++++++++
 drivers/video/mxsfb.c                   |    9 +++++++++
 sound/soc/mxs/mxs-saif.c                |    8 ++++++++
 33 files changed, 159 insertions(+), 0 deletions(-)
