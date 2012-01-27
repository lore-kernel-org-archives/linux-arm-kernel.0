From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Jan 2012 12:10:24 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20120127111024.GB5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Another round of small fixes for -rc, please pull

Sascha

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes

Fabio Estevam (3):
      ARM: mx3: Let mx31 and mx35 share the same CCM header file
      ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
      ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board

 arch/arm/configs/imx_v4_v5_defconfig               |    1 +
 arch/arm/mach-imx/Makefile                         |    4 +-
 arch/arm/mach-imx/clock-imx31.c                    |    2 +-
 arch/arm/mach-imx/clock-imx35.c                    |  166 +++++++++-----------
 .../mach-imx/{crmregs-imx31.h => crmregs-imx3.h}   |   16 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +-
 arch/arm/mach-imx/mm-imx3.c                        |    4 +-
 arch/arm/mach-imx/pm-imx3.c                        |   36 +++++
 arch/arm/plat-mxc/include/mach/common.h            |    8 +
 9 files changed, 142 insertions(+), 97 deletions(-)
 rename arch/arm/mach-imx/{crmregs-imx31.h => crmregs-imx3.h} (93%)
 create mode 100644 arch/arm/mach-imx/pm-imx3.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
