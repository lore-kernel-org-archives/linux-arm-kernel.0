From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Apr 2010 11:41:10 +0200
Subject: MXC Pull request
Message-ID: <20100408094110.GH3688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following for -rc.

Sascha

The following changes since commit 7da23b86e14b77c094b11a9fa5ef5b3758fc9193:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alberto Panizzo (5):
      MXC: mach-mx31_3ds: Update variable names over recent mach name modification.
      MXC: mach-mx31_3ds: Add support for on board NAND Flash.
      MXC: mach-mx31_3ds: Add SPI1 device support.
      MXC: mach-mx31_3ds: add support for freescale mc13783 power management device.
      MXC: mach_armadillo5x0: Add USB Host support.

Andrea Gelmini (2):
      ARM mach-mx3: duplicated include
      ARM mach-mx3: duplicated include

Sascha Hauer (6):
      i.MX51 Babbage: Add uncompress output
      i.MX51: Use correct clock for gpt
      i.MX51: map TZIC dynamically
      i.MX51: determine silicon revision dynamically
      i.MX51: remove NFC AXI static mapping
      Merge branch 'mx51' into mxc-rc

Vladimir Zapolskiy (3):
      imx31: fix parent clock for rtc
      imx3: Add watchdog platform device support
      imx31: add watchdog device on litekit board.

 arch/arm/mach-mx3/Kconfig                          |   10 ++
 arch/arm/mach-mx3/clock-imx31.c                    |    5 +-
 arch/arm/mach-mx3/devices.c                        |   19 ++-
 arch/arm/mach-mx3/devices.h                        |    3 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c              |  166 ++++++++++++++++++++
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |  116 ++++++++++++---
 arch/arm/mach-mx3/mach-pcm037.c                    |    1 -
 arch/arm/mach-mx3/mx31lite-db.c                    |    2 +-
 arch/arm/mach-mx5/clock-mx51.c                     |    2 +-
 arch/arm/mach-mx5/cpu.c                            |   53 ++++++
 arch/arm/mach-mx5/mm.c                             |   32 ++---
 .../mach/{board-mx31pdk.h => board-mx31_3ds.h}     |    6 +-
 arch/arm/plat-mxc/include/mach/mx51.h              |   33 ++---
 arch/arm/plat-mxc/include/mach/uncompress.h        |    4 +
 14 files changed, 382 insertions(+), 70 deletions(-)
 rename arch/arm/plat-mxc/include/mach/{board-mx31pdk.h =>
board-mx31_3ds.h} (93%)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
