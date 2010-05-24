From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 May 2010 21:54:30 +0200
Subject: [PATCH 00/16] imx patches for 2.6.36
Message-ID: <20100524195430.GA28403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

in reply to this mail you can find some more clean-ups and updates for
the imx platforms.  Shortlog and diffstat can be found below.

They are compile tested (all imx defconfigs) and merge fine with
Sascha's for-linus and for-rmk branches.

Best regards
Uwe

The following changes since commit 7e125f7b9cbfce4101191b8076d606c517a73066:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/ide-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/for-2.6.36

Uwe Kleine-K?nig (16):
      arm/mx3: rename mach-mx35pdk.c to mach-mx35_3ds.c matching its arch number
      arm/mx25: rename mach-mx25pdk.c to mach-mx25_3ds.c matching its arch number
      arm/mx1: add CONFIG_VIDEO_MX1 to defconfig
      arm/mx1: don't use deprecated symbol names
      arm/mx2/pca100: add #ifdef to fix compiler warning
      arm/mx1/scb9328: fix type of uart1_mxc_exit to make compiler happy
      arm/mx2/mx27_3ds: document alternative names and remove empty header
      arm/imx: remove empty and unused board headers
      arm/mx2/mbimx27: compile fixes with CONFIG_TOUCHSCREEN_ADS7846=y
      arm/mx3/kzm_arm11_01: fold board header in its only user
      arm/mx2/mx21ads: fold board header in its only user
      arm/mx2/mx27ads: fold board header in its only user
      arm/mx3/qong: get rid of nearly empty header
      arm/mx3/mx31_3ds: fold board header in its only user
      arm/mx3/mx31ads: fold board header in its only user
      arm/mxc: grammar fix

 arch/arm/configs/mx1_defconfig                     |    6 +-
 arch/arm/configs/mx27_defconfig                    |    2 +-
 arch/arm/mach-mx1/Makefile                         |    1 -
 arch/arm/mach-mx1/clock.c                          |    3 +-
 arch/arm/mach-mx1/crm_regs.h                       |    4 +-
 arch/arm/mach-mx1/devices.c                        |  117 ++++----
 arch/arm/mach-mx1/generic.c                        |   13 +-
 arch/arm/mach-mx1/mach-mx1ads.c                    |   12 +-
 arch/arm/mach-mx1/mach-scb9328.c                   |   15 +-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c       |    5 +-
 arch/arm/mach-mx2/mach-imx27lite.c                 |    1 -
 arch/arm/mach-mx2/mach-mx21ads.c                   |   36 ++-
 arch/arm/mach-mx2/mach-mx27_3ds.c                  |    7 +-
 arch/arm/mach-mx2/mach-mx27ads.c                   |   32 ++-
 arch/arm/mach-mx2/mach-pca100.c                    |    2 +
 arch/arm/mach-mx25/Makefile                        |    2 +-
 .../mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c}  |    6 +
 arch/arm/mach-mx3/Makefile                         |    2 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c              |    1 -
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |   18 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |   41 ++-
 arch/arm/mach-mx3/mach-mx31ads.c                   |   42 ++-
 .../mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c}   |    6 +
 arch/arm/mach-mx3/mach-pcm037.c                    |    1 -
 arch/arm/mach-mx3/mach-qong.c                      |    3 +-
 .../arm/plat-mxc/include/mach/board-armadillo5x0.h |   15 -
 .../plat-mxc/include/mach/board-eukrea_cpuimx27.h  |    2 +-
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h    |   39 ---
 arch/arm/plat-mxc/include/mach/board-mx21ads.h     |   52 ---
 arch/arm/plat-mxc/include/mach/board-mx27ads.h     |  344 --------------------
 arch/arm/plat-mxc/include/mach/board-mx27lite.h    |   14 -
 arch/arm/plat-mxc/include/mach/board-mx27pdk.h     |   14 -
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |  117 -------
 arch/arm/plat-mxc/include/mach/board-mx31lilly.h   |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lite.h    |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx35pdk.h     |   22 --
 arch/arm/plat-mxc/include/mach/board-pcm037.h      |   22 --
 arch/arm/plat-mxc/include/mach/board-pcm038.h      |    2 +-
 arch/arm/plat-mxc/include/mach/board-pcm043.h      |   22 --
 arch/arm/plat-mxc/include/mach/board-qong.h        |   17 -
 41 files changed, 272 insertions(+), 794 deletions(-)
 rename arch/arm/mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c} (97%)
 rename arch/arm/mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c} (96%)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx21ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27lite.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx35pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm037.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm043.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-qong.h


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
