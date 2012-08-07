From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 07 Aug 2012 04:34:39 -0600
Subject: [PATCH 0/2] ARM: OMAP: smatch warning cleanup and string unwrapping
Message-ID: <20120807103009.8053.69389.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes several bugs uncovered by smatch.  It also unwraps
all of the wrapped strings across the arch/arm/*omap* codebase.  Some
warning messages have been reformatted for concision and consistency.
And some printk(KERN_* ... have been converted to pr_*( ...

This series is intended for v3.7 cleanup.  It has been only lightly
tested; a pull request will be sent after testing is completed.


- Paul

---

warnings_cleanup_3.7
   text	   data	    bss	    dec	    hex	filename
7318144	 764324	5613004	13695472	 d0f9f0	vmlinux.omap2plus_defconfig.orig
7318188	 764348	5613004	13695540	 d0fa34	vmlinux.omap2plus_defconfig


Paul Walmsley (2):
      ARM: OMAP: clean up some smatch warnings, fix some printk(KERN_ERR ...
      ARM: OMAP: unwrap strings


 arch/arm/mach-omap1/board-htcherald.c       |    3 -
 arch/arm/mach-omap1/clock.c                 |    4 +
 arch/arm/mach-omap1/clock_data.c            |   13 ++---
 arch/arm/mach-omap1/dma.c                   |    5 +-
 arch/arm/mach-omap1/lcd_dma.c               |   15 +----
 arch/arm/mach-omap1/leds-h2p2-debug.c       |   12 +++-
 arch/arm/mach-omap2/board-n8x0.c            |    7 +--
 arch/arm/mach-omap2/board-overo.c           |    6 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 +--
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c      |   10 +---
 arch/arm/mach-omap2/clkt_clksel.c           |   28 +++++-----
 arch/arm/mach-omap2/clkt_dpll.c             |    8 +--
 arch/arm/mach-omap2/clock.c                 |   20 +++----
 arch/arm/mach-omap2/clock3xxx.c             |    3 -
 arch/arm/mach-omap2/clockdomain.c           |   74 ++++++++++++---------------
 arch/arm/mach-omap2/common-board-devices.c  |    3 -
 arch/arm/mach-omap2/dpll3xxx.c              |    7 ++-
 arch/arm/mach-omap2/gpio.c                  |    1 
 arch/arm/mach-omap2/gpmc.c                  |    5 +-
 arch/arm/mach-omap2/id.c                    |    5 +-
 arch/arm/mach-omap2/irq.c                   |    5 +-
 arch/arm/mach-omap2/omap_hwmod.c            |   16 +++---
 arch/arm/mach-omap2/opp.c                   |   15 ++---
 arch/arm/mach-omap2/pm.c                    |    4 +
 arch/arm/mach-omap2/pm34xx.c                |    8 +--
 arch/arm/mach-omap2/pm44xx.c                |    8 +--
 arch/arm/mach-omap2/powerdomain.c           |   36 ++++++-------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    4 +
 arch/arm/mach-omap2/powerdomain44xx.c       |    4 +
 arch/arm/mach-omap2/prcm.c                  |    8 +--
 arch/arm/mach-omap2/serial.c                |   12 +++-
 arch/arm/mach-omap2/sr_device.c             |   13 ++---
 arch/arm/mach-omap2/timer.c                 |    2 -
 arch/arm/mach-omap2/vc.c                    |    5 +-
 arch/arm/mach-omap2/voltage.c               |   12 ++--
 arch/arm/mach-omap2/vp.c                    |   16 +++---
 arch/arm/plat-omap/dma.c                    |   61 +++++++++-------------
 arch/arm/plat-omap/mux.c                    |    2 -
 arch/arm/plat-omap/omap-pm-noop.c           |   39 +++++++-------
 arch/arm/plat-omap/omap_device.c            |   25 ++++-----
 40 files changed, 239 insertions(+), 292 deletions(-)
