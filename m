From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 27 Jun 2012 14:18:32 +0530
Subject: [PATCH v2 0/3] Prepare for OMAP2+ movement to Common Clk
Message-ID: <1340786915-29507-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
* Dropped all driver clk_prepare/clk_unprepare changes, will be
  sent seperately to respective lists

This is a preparatory series for the OMAP Common Clk
conversion. They mostly add clk_prepare/clk_unprepare
in OMAP platform code. Also gets rid of omap_clk_get_by_name
and uses clk_get, and removes all direct 'struct clk'
dereferrencing and uses helpers similar to what is provided
by Common Clk.

Patches are boot tested on OMAP2430sdp, 3630 Beagle-Xm
and 4430/4460 Panda and suspend tested on 3630 Beagle-Xm
and 4430 Panda. Patches apply on 3.5-rc4.

Rajendra Nayak (3):
  ARM: omap: clk: add clk_prepare and clk_unprepare
  ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
  ARM: omap: clk: Remove all direct dereferencing of struct clk

 arch/arm/mach-omap2/board-apollon.c          |    4 +-
 arch/arm/mach-omap2/board-h4.c               |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    4 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   18 +++---
 arch/arm/mach-omap2/clkt_clksel.c            |   84 ++++++++++++++++++--------
 arch/arm/mach-omap2/clkt_dpll.c              |   24 ++++---
 arch/arm/mach-omap2/clock.c                  |    9 ++-
 arch/arm/mach-omap2/clock2420_data.c         |   17 +++++
 arch/arm/mach-omap2/clock2430_data.c         |   21 +++++++
 arch/arm/mach-omap2/clock3xxx.c              |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   24 +++++++
 arch/arm/mach-omap2/clock44xx_data.c         |   17 +++++
 arch/arm/mach-omap2/display.c                |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c               |   45 ++++++++------
 arch/arm/mach-omap2/gpmc.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   21 ++++---
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/mach-omap2/pm24xx.c                 |    2 +
 arch/arm/mach-omap2/usb-fs.c                 |    4 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 +
 arch/arm/plat-omap/omap_device.c             |    6 +-
 23 files changed, 233 insertions(+), 97 deletions(-)
