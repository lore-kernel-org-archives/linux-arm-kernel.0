From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  2 Mar 2011 12:01:19 +0100
Subject: [PATCH] i.MX some patches
Message-ID: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following are some cleanup patches to save ifdefs in i.MX code.

Sascha

Sascha Hauer (4):
      ARM i.MX: Move gpio initialization to SoC specific files
      ARM i.MX: iomux v1 initialization away from initcall
      ARM i.MX31 lilly: remove incomplete otg support
      ARM i.MX: introduce imx_otg_ulpi_create to create ULPI transceivers

 arch/arm/mach-imx/mach-cpuimx27.c         |   24 +++----
 arch/arm/mach-imx/mach-mx27_3ds.c         |   13 ++--
 arch/arm/mach-imx/mach-pca100.c           |   21 +++---
 arch/arm/mach-imx/mm-imx1.c               |   14 +++-
 arch/arm/mach-imx/mm-imx21.c              |   16 ++++-
 arch/arm/mach-imx/mm-imx25.c              |   11 +++-
 arch/arm/mach-imx/mm-imx27.c              |   16 ++++-
 arch/arm/mach-mx3/mach-armadillo5x0.c     |   20 +++---
 arch/arm/mach-mx3/mach-mx31_3ds.c         |   20 +++---
 arch/arm/mach-mx3/mach-mx31lilly.c        |   68 ++----------------
 arch/arm/mach-mx3/mach-mx31lite.c         |   12 +--
 arch/arm/mach-mx3/mach-mx31moboard.c      |   11 +--
 arch/arm/mach-mx3/mach-pcm037.c           |   19 ++---
 arch/arm/mach-mx3/mach-pcm043.c           |   12 +--
 arch/arm/mach-mx3/mm.c                    |   20 ++++-
 arch/arm/mach-mx3/mx31moboard-smartbot.c  |    6 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c    |    8 +-
 arch/arm/mach-mx5/mm-mx50.c               |   13 +++-
 arch/arm/mach-mx5/mx51_efika.c            |    8 +-
 arch/arm/plat-mxc/gpio.c                  |  110 -----------------------------
 arch/arm/plat-mxc/include/mach/gpio.h     |   15 ++++
 arch/arm/plat-mxc/include/mach/iomux-v1.h |    2 +
 arch/arm/plat-mxc/include/mach/ulpi.h     |    9 +++
 arch/arm/plat-mxc/iomux-v1.c              |   24 +------
 arch/arm/plat-mxc/ulpi.c                  |    5 ++
 25 files changed, 190 insertions(+), 307 deletions(-)
