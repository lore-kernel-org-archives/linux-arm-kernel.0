From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Dec 2011 17:13:02 +0000
Subject: [GIT PULL] arm-soc fixes for 3.2, part 3
Message-ID: <201112081713.02697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Another week gone by, so here is the latest set of fixes for arm-soc.
The rate of patches is going down slowly, but at least they are
all trivial.

	Arnd

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

Anders Darander (1):
      ARM: at91: Fix USB AT91 gadget registration

Arnd Bergmann (7):
      Merge branch 'at91-fixes' of git://github.com/at91linux/linux-at91 into fixes
      Merge branch 'imx/fix-irqdomain' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes
      Merge branch 'fixes' of git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel into fixes
      Merge branch 'mxs/fixes' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes
      Merge branch 'fixes' of git://gitorious.org/linux-davinci/linux-davinci into fixes
      Merge branch 'samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge branch 'fixes' of git://github.com/hzhuang1/linux into fixes

Barry Song (2):
      ARM: CSR: fix build error due to new mdesc->dma_zone_size
      ARM: CSR: PM: fix build error due to undeclared 'THIS_MODULE'

Christian Hitz (1):
      ARM: at91: fix NAND bus width decoding from system_rev

Dong Aisheng (1):
      ARM: mxs/tx28: add __initconst for fec pdata

Hans Verkuil (1):
      ARM: davinci: dm646x evm: wrong register used in setup_vpif_input_channel_mode

Heiko Stuebner (1):
      MAINTAINERS: Consolidate Samsung MAINTAINERS

Janusz Krzysztofik (3):
      ARM: OMAP1: Remove unsafe clock values from omap1_defconfig
      ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
      ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: fix clock conid for atmel_tcb.1 on 9260/9g20

Jett.Zhou (1):
      ARM: sa1100: fix build error

Kukjin Kim (1):
      Merge branch 'next/topic-update-maintainer' into samsung-fixes-2

Lauri Hintsala (1):
      ARM: mxs: fix machines' initializers order

Manjunathappa, Prakash (1):
      ARM: davinci: da850 evm: change audio edma event queue to EVENTQ_0

Mark Brown (5):
      MAINTAINERS: Add linux-samsung-soc mailing list for Samsung
      MAINTAINERS: Extend Samsung patterns to cover SPI and ASoC drivers
      ARM: S3C64XX: Remove extern from definition of framebuffer setup call
      ARM: S3C64XX: Add linux/export.h to dev-spi.c
      ARM: S3C64XX: Staticise s3c6400_sysclass

Murali Karicheri (2):
      ARM: davinci: psc: fix incorrect mask
      ARM: davinci: psc: fix incorrect offsets

Olof Johansson (1):
      Merge branch 'fixes' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Peter Rusko (1):
      ARM: mx28: LRADC macro rename

Sekhar Nori (1):
      ARM: davinci: dm646x does not have a DSP domain

Shankarmurthy,Akshay (1):
      ARM: davinci: dm365 evm: align nand partition table to u-boot

Shawn Guo (2):
      arm/imx: fix return type of callback passed to of_irq_init()
      arm/imx: fix irq_base for gpio

Tony Lindgren (1):
      ARM: OMAP1: Fix reprogramming of DPLL1 for systems that boot at rates below 60MHz

Wolfram Sang (1):
      arm: mx23: recognise stmp378x as mx23

 MAINTAINERS                                  |   27 ++++---------------------
 arch/arm/configs/omap1_defconfig             |    5 ----
 arch/arm/mach-at91/at91rm9200_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9260.c             |    6 ++--
 arch/arm/mach-at91/at91sam9260_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c     |    2 +-
 arch/arm/mach-at91/include/mach/system_rev.h |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c      |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c      |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c     |    6 ++--
 arch/arm/mach-davinci/dm646x.c               |    1 -
 arch/arm/mach-davinci/include/mach/psc.h     |    5 +++-
 arch/arm/mach-davinci/psc.c                  |   18 ++++++++--------
 arch/arm/mach-imx/mach-imx6q.c               |    9 ++++---
 arch/arm/mach-mx5/imx51-dt.c                 |   12 ++++++----
 arch/arm/mach-mx5/imx53-dt.c                 |   12 ++++++----
 arch/arm/mach-mxs/include/mach/mx28.h        |    4 +-
 arch/arm/mach-mxs/include/mach/mxs.h         |    1 +
 arch/arm/mach-mxs/mach-m28evk.c              |    2 +-
 arch/arm/mach-mxs/mach-stmp378x_devb.c       |    2 +-
 arch/arm/mach-mxs/module-tx28.c              |    4 +-
 arch/arm/mach-omap1/clock_data.c             |   12 +++++++++-
 arch/arm/mach-prima2/pm.c                    |    1 +
 arch/arm/mach-prima2/prima2.c                |    1 +
 arch/arm/mach-s3c64xx/dev-spi.c              |    1 +
 arch/arm/mach-s3c64xx/s3c6400.c              |    2 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c       |    2 +-
 arch/arm/mach-sa1100/Makefile.boot           |    4 +-
 29 files changed, 74 insertions(+), 77 deletions(-)
