From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Dec 2009 19:52:48 +0100
Subject: [PATCH 00/20] imx cleanup series
Message-ID: <20091216185046.GA16984@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is the next step of a big cleanup of arch-mx* + plat-mxc.

The patch by Wolfgang Denk is included because otherwise it would
conflict with the series.

diffstat and shortlog are below.

I think I will add some more patches until the next merge window opens,
I send now to get some feedback and make people aware of these changes.
Note that the branch may change in a non-fast-forward manner.

Best regards
Uwe

The following changes since commit 8bea8672edfca7ec5f661cafb218f1205863b343:
  Stephen Rothwell (1):
        mfd: compile fix for twl4030 renaming

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx

Uwe Kleine-K?nig (19):
      imx/mx2: fold crm_regs.h into its only consumer
      imx/clock-imx21: use a macro to define registers
      imx/clock-imx27: use a macro to define registers
      imx/mach-mx2: use constants namespaced by the corresponding SOC (easy part)
      imx/mach-mx3: use constants namespaced by the corresponding SOC (easy part)
      imx/mx3: rename clock.c and iomux.c to {clock,iomux}-imx31.c
      imx/mx1: add newline at end of Makefile
      imx/mx1: rename files defining a machine to mach-$mach.c
      imx: rename Kconfig symbol for "Eukrea CPUIMX27 module"
      imx: rename Kconfig symbol for "LogicPD MX27 LITEKIT platform"
      imx/mx2: rename files defining a machine to mach-$mach.c
      imx/mx3: rename files defining a machine to mach-$mach.c
      imx: provide helper macro to define IO_ADDRESS
      imx21: define and use MX21_IO_ADDRESS
      imx27: define and use MX27_IO_ADDRESS
      imx31: define and use MX31_IO_ADDRESS
      imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS
      imx35: define and use MX35_IO_ADDRESS
      mx3/kzm_arm11_01: define and use board specific IO_ADDRESS macro

Wolfgang Denk (1):
      ARM: MX3: make CPU revision number detection work on all boards

 arch/arm/configs/mx27_defconfig                    |    2 +-
 arch/arm/mach-mx1/Makefile                         |    4 +-
 arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c}      |    2 +-
 arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c}    |    2 +-
 arch/arm/mach-mx2/Kconfig                          |    8 +-
 arch/arm/mach-mx2/Makefile                         |   17 +-
 arch/arm/mach-mx2/clock_imx21.c                    |  236 ++++++++++++++++++-
 arch/arm/mach-mx2/clock_imx27.c                    |   33 ++--
 arch/arm/mach-mx2/cpu_imx27.c                      |    3 +-
 arch/arm/mach-mx2/crm_regs.h                       |  258 --------------------
 .../{eukrea_cpuimx27.c => mach-cpuimx27.c}         |   12 +-
 arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} |    4 +-
 arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c}    |   10 +-
 arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c}   |    4 +-
 arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c}    |    6 +-
 arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c}  |    4 +-
 arch/arm/mach-mx2/{pca100.c => mach-pca100.c}      |    4 +-
 arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c}      |    8 +-
 arch/arm/mach-mx2/pcm970-baseboard.c               |    4 +-
 arch/arm/mach-mx3/Makefile                         |   24 +-
 arch/arm/mach-mx3/{clock.c => clock-imx31.c}       |    5 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    4 +-
 arch/arm/mach-mx3/crm_regs.h                       |    2 +-
 arch/arm/mach-mx3/{iomux.c => iomux-imx31.c}       |    2 +-
 .../{armadillo5x0.c => mach-armadillo5x0.c}        |   12 +-
 .../mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c}   |   32 ++-
 arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c}   |   15 +-
 arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c}    |   19 +-
 .../arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} |    8 +-
 arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c}  |   19 +-
 .../mach-mx3/{mx31moboard.c => mach-mx31moboard.c} |    4 +-
 arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c}    |    4 +-
 arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c}      |   16 +-
 arch/arm/mach-mx3/{pcm043.c => mach-pcm043.c}      |    4 +-
 arch/arm/mach-mx3/{qong.c => mach-qong.c}          |   14 +-
 arch/arm/mach-mx3/mm.c                             |    5 +
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |    2 +-
 arch/arm/plat-mxc/include/mach/hardware.h          |    4 +
 arch/arm/plat-mxc/include/mach/mx21.h              |    7 +
 arch/arm/plat-mxc/include/mach/mx25.h              |   19 +-
 arch/arm/plat-mxc/include/mach/mx27.h              |    7 +
 arch/arm/plat-mxc/include/mach/mx31.h              |    9 +
 arch/arm/plat-mxc/include/mach/mx35.h              |    8 +
 43 files changed, 433 insertions(+), 433 deletions(-)
 rename arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c} (98%)
 rename arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} (98%)
 delete mode 100644 arch/arm/mach-mx2/crm_regs.h
 rename arch/arm/mach-mx2/{eukrea_cpuimx27.c => mach-cpuimx27.c} (94%)
 rename arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} (96%)
 rename arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c} (96%)
 rename arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c} (96%)
 rename arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c} (98%)
 rename arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c} (98%)
 rename arch/arm/mach-mx2/{pca100.c => mach-pca100.c} (98%)
 rename arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c} (97%)
 rename arch/arm/mach-mx3/{clock.c => clock-imx31.c} (99%)
 rename arch/arm/mach-mx3/{iomux.c => iomux-imx31.c} (98%)
 rename arch/arm/mach-mx3/{armadillo5x0.c => mach-armadillo5x0.c} (97%)
 rename arch/arm/mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c} (89%)
 rename arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c} (95%)
 rename arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c} (96%)
 rename arch/arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} (97%)
 rename arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c} (94%)
 rename arch/arm/mach-mx3/{mx31moboard.c => mach-mx31moboard.c} (99%)
 rename arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c} (97%)
 rename arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c} (97%)
 rename arch/arm/mach-mx3/{pcm043.c => mach-pcm043.c} (98%)
 rename arch/arm/mach-mx3/{qong.c => mach-qong.c} (95%)

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
