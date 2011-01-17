From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Jan 2011 06:31:13 +0200
Subject: [PATCH 0/7] OMAP compile warning fix
Message-ID: <1295238680-26738-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I gave it a shot at dropping a few compile warnings
from omap1-only and omap2-only builds.

Following are 7 patches which I came up with. All
compile tested with omap1_defconfig and omap2_defconfig
(the latter being a result of omap2plus_defconfig -
omap3 and omap4 support and adding any other config option
which was disabled)

There are a few more warnings to clean up, though. I didn't
tackle all of them.

Felipe Balbi (7):
  arm: omap: i2c: fix compile warning
  arm: omap1: fix compile warning
  arm: omap1: fix compile warnings
  arm: omap1: fix a bunch of section mismatches
  arm: omap2: mux: fix compile warning
  arm: omap2: irq: fix compile warning:
  arm: omap2: clksel: fix compile warning

 arch/arm/mach-omap1/board-ams-delta.c  |   14 +++---
 arch/arm/mach-omap1/board-fsample.c    |    2 +-
 arch/arm/mach-omap1/board-palmte.c     |   13 -----
 arch/arm/mach-omap2/clkt_clksel.c      |    5 ++-
 arch/arm/mach-omap2/irq.c              |    4 +-
 arch/arm/mach-omap2/mux.c              |    2 +-
 arch/arm/plat-omap/i2c.c               |    2 +-
 arch/arm/plat-omap/include/plat/fpga.h |   92 ++++++++++++++++----------------
 8 files changed, 62 insertions(+), 72 deletions(-)

-- 
1.7.3.4.598.g85356
