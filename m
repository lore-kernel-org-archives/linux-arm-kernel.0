From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jul 2011 10:14:24 +0200
Subject: [GIT PULL] i.MX cleanups
Message-ID: <20110707081424.GY6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

[once again with the list on Cc]

Please pull the following i.MX cleanup patches. This branch is directly
based on the previous fixes pull request. I tried making this is
independent on the fixes branch, but it resulted in merge conflicts.


The following changes since commit 58f45e3c6f4fd2b9b9d7d43af71409a79a4b4cf6:

  ARM: i.MX53: Fix IOMUX type o's (2011-07-07 09:59:42 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git cleanup

Fabio Estevam (6):
      ARM: mx5/mx51_babbage: Move GPIO initialization for USB PHY Reset line to common place
      ARM: mx5/mx51_babbage: Use gpio_request_array for USBH1 pins
      ARM: imx/mach-apf9328: Simplify UART0 registration
      ARM: mach-imx/scb9328: Make the UART gpio setup simpler
      ARM: mach-imx/mx27_3ds: Use the standard gpio_to_irq function
      ARM: mach-imx/mx27_3ds: Do not annotate the chip select as internal

H Hartley Sweeten (1):
      plat-mxc/pwm.c: use resource_size()

Sascha Hauer (9):
      ARM i.MX: fix last user of iomux.h and remove it
      ARM i.MX: define CLOCK_TICK_RATE to bogus value
      ARM i.MX: remove SoC defines around header includes
      ARM i.MX: dmav1: kill SoC ifdefs
      ARM i.MX mxc.h: use CONFIG_SOC_* instead of CONFIG_ARCH_*
      ARM i.MX tzic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX avic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage
      ARM i.MX debug macro: use CONFIG_SOC_* instead of CONFIG_ARCH_*

Uwe Kleine-K?nig (3):
      ARM: imx: convert to new leds-gpio registration helper
      ARM: mx5: convert to new leds-gpio registration helper
      ARM: mxs/tx28: convert to new leds-gpio registration helper

 arch/arm/mach-imx/Kconfig                      |    5 +++
 arch/arm/mach-imx/dma-v1.c                     |   25 ++---------------
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |   23 ++++------------
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   15 +++-------
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |   13 ++-------
 arch/arm/mach-imx/mach-apf9328.c               |    7 +----
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c              |   15 +++++-----
 arch/arm/mach-imx/mach-mx31moboard.c           |   14 ++-------
 arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-scb9328.c               |   17 ++----------
 arch/arm/mach-imx/mx31lite-db.c                |   15 +++-------
 arch/arm/mach-mx5/Kconfig                      |    4 +++
 arch/arm/mach-mx5/board-cpuimx51.c             |   12 +++-----
 arch/arm/mach-mx5/board-mx51_3ds.c             |    3 +-
 arch/arm/mach-mx5/board-mx51_babbage.c         |   34 ++++++++++++------------
 arch/arm/mach-mx5/board-mx51_efikamx.c         |   15 +++-------
 arch/arm/mach-mx5/board-mx51_efikasb.c         |   16 +++--------
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |   24 ++++------------
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |   19 +++----------
 arch/arm/mach-mxs/Kconfig                      |    1 +
 arch/arm/mach-mxs/mach-tx28.c                  |    5 +--
 arch/arm/plat-mxc/avic.c                       |   12 +++++---
 arch/arm/plat-mxc/include/mach/debug-macro.S   |   10 +++---
 arch/arm/plat-mxc/include/mach/hardware.h      |   28 +++----------------
 arch/arm/plat-mxc/include/mach/iomux-v1.h      |    3 --
 arch/arm/plat-mxc/include/mach/iomux.h         |   26 ------------------
 arch/arm/plat-mxc/include/mach/mxc.h           |    8 +++---
 arch/arm/plat-mxc/include/mach/timex.h         |   13 +-------
 arch/arm/plat-mxc/pwm.c                        |    8 +++---
 arch/arm/plat-mxc/tzic.c                       |    4 ++-
 31 files changed, 120 insertions(+), 278 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
