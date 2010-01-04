From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Jan 2010 15:12:17 +0100
Subject: mxc pull request for -rc
Message-ID: <20100104141217.GB6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following i.MX related stuff for -rc.

Sascha


The following changes since commit 6b7b284958d47b77d06745b36bc7f36dab769d9b:
  Linus Torvalds (1):
        Linux 2.6.33-rc2

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alan Carvalho de Assis (1):
      mx27: mxt_td60: Remove not used UART pins

Baruch Siach (3):
      mx25: s/NO_PAD_CTL/NO_PAD_CTRL/
      mx25: add support for FEC on i.MX25
      mx25: pdk: add platform code for FEC support

Guennadi Liakhovetski (1):
      mx3: add support for the mt9v022 camera sensor to pcm037 platform

Uwe Kleine-K?nig (1):
      imx/mx3: depend on USB_ULPI for otg_ulpi_create

Valentin Longchamp (1):
      mx31moboard: fix usbh device names

Wolfgang Denk (1):
      ARM: MX3: make CPU revision number detection work on all boards

 arch/arm/mach-mx2/mxt_td60.c                |   24 -----------
 arch/arm/mach-mx25/clock.c                  |    2 +
 arch/arm/mach-mx25/devices.c                |   19 +++++++++
 arch/arm/mach-mx25/devices.h                |    1 +
 arch/arm/mach-mx25/mx25pdk.c                |   46 ++++++++++++++++++++-
 arch/arm/mach-mx3/Kconfig                   |    3 +-
 arch/arm/mach-mx3/mm.c                      |    5 ++
 arch/arm/mach-mx3/mx31ads.c                 |    5 --
 arch/arm/mach-mx3/mx31lite.c                |    9 ++--
 arch/arm/mach-mx3/mx31moboard-devboard.c    |    2 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c     |    2 +-
 arch/arm/mach-mx3/mx31moboard.c             |    7 +++-
 arch/arm/mach-mx3/mx31pdk.c                 |    5 --
 arch/arm/mach-mx3/pcm037.c                  |   32 +++++++++++---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |   58 +++++++++++++-------------
 arch/arm/plat-mxc/include/mach/mx25.h       |    4 ++
 16 files changed, 143 insertions(+), 81 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
