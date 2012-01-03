From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 3 Jan 2012 09:51:37 +0100
Subject: [GIT PULL] i.MX patches for eukrea boards
Message-ID: <20120103085137.GH5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following eukrea board specific patches. They
currently conflict with the patches merging mach-mx5 to mach-imx.
Let me know if I have to rebase them.

Sascha

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-eukrea

Eric B?nard (9):
      mxc_udc: add workaround for ENGcm09152 for i.MX25
      eukrea_cpuimx25: enable workaround ENGcm09152
      mbimxsd25: add spi controler and spidev support
      cpuimx25: add watchdog support
      mbimxsd35: add spi controler and spidev support
      eukrea-cpuimx51: remove board
      cpuimx51sd: add watchdog support
      mbimx51sd: add audio codec support
      eukrea-cpuimx51sd: support rev2 PCB

 arch/arm/configs/mx5_defconfig                 |    1 -
 arch/arm/mach-imx/Kconfig                      |    3 +
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   39 +++
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |   39 +++
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 +
 arch/arm/mach-mx5/Kconfig                      |   32 +---
 arch/arm/mach-mx5/Makefile                     |    2 -
 arch/arm/mach-mx5/board-cpuimx51.c             |  300 ------------------------
 arch/arm/mach-mx5/board-cpuimx51sd.c           |   49 ++++-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |  206 ----------------
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |   28 +++
 drivers/usb/gadget/fsl_mxc_udc.c               |   22 +-
 12 files changed, 167 insertions(+), 556 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/board-cpuimx51.c
 delete mode 100644 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
