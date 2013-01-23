From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 23:34:18 +0000
Subject: [RFC PATCH 0/6] ARM: kirkwood: cleanup DT conversion
Message-ID: <cover.1358983578.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This is a first cut at cleaning up mach-kirkwood/.  There are a few DT
conversions (topkick -> mvsdio, pinctrl) which, once reviewed, I'll put in the
normal pull request cycle.

The others which remove board-*.c files, I'll keep updating against
mvebu/for-next, and then apply at the end of the merge window.

Please test as you are able.

thx,

Jason.

Jason Cooper (6):
  ARM: kirkwood: topkick: init mvsdio via DT
  ARM: kirkwood: topkick: convert to pinctrl
  ARM: kirkwood: nsa310: cleanup includes and unneeded code
  ARM: kirkwood: nsa310: convert to pinctrl
  ARM: kirkwood: consolidate DT init of pcie
  ARM: kirkwood: consolidate mv643xx_eth init for DT

 arch/arm/boot/dts/kirkwood-nsa310.dts        |  99 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts       |  95 ++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig               | 101 -------------------
 arch/arm/mach-kirkwood/Makefile              |  15 ---
 arch/arm/mach-kirkwood/board-dnskw.c         |   7 --
 arch/arm/mach-kirkwood/board-dockstar.c      |  32 ------
 arch/arm/mach-kirkwood/board-dreamplug.c     |  35 -------
 arch/arm/mach-kirkwood/board-dt.c            | 140 ++++++++++++++++++++-------
 arch/arm/mach-kirkwood/board-goflexnet.c     |  34 -------
 arch/arm/mach-kirkwood/board-ib62x0.c        |  29 ------
 arch/arm/mach-kirkwood/board-iconnect.c      |  32 ------
 arch/arm/mach-kirkwood/board-lsxl.c          |  36 -------
 arch/arm/mach-kirkwood/board-mplcec4.c       |  36 -------
 arch/arm/mach-kirkwood/board-ns2.c           |  34 -------
 arch/arm/mach-kirkwood/board-nsa310.c        |  58 -----------
 arch/arm/mach-kirkwood/board-openblocks_a6.c |  26 -----
 arch/arm/mach-kirkwood/board-ts219.c         |  13 ---
 arch/arm/mach-kirkwood/board-usi_topkick.c   |  77 ---------------
 arch/arm/mach-kirkwood/common.h              |  69 -------------
 19 files changed, 298 insertions(+), 670 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 delete mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
 delete mode 100644 arch/arm/mach-kirkwood/board-goflexnet.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c
 delete mode 100644 arch/arm/mach-kirkwood/board-iconnect.c
 delete mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
 delete mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ns2.c
 delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
 delete mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
 delete mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c

-- 
1.8.1.1
