From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:10 -0700
Subject: [PATCH 0/7] ARM: OMAP2+: hwmod/timer: first set of cleanups for 3.4
Message-ID: <20120130101251.10450.58423.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series does some cleanup and documentation on the OMAP hwmod code
(and a bit of the OMAP4 data) and timer code. It is the first
prerequisite series to removing a big chunk of hwmod data -- that will
be done in a later series.

Boot-tested on an OMAP35xx BeagleBoard and OMAP44xx ES2 Pandaboard.

This series is also available via git from git://git.pwsan.com/linux-2.6 in
the branch "hwmod_code_cleanup_3.4".


- Paul

---

hwmod_code_cleanup_3.4
   text	   data	    bss	    dec	    hex	filename
6592293	 678588	5590684	12861565	 c4407d	vmlinux.orig
6592597	 677948	5590684	12861229	 c43f2d	vmlinux.patched

Paul Walmsley (7):
      ARM: OMAP2+: hwmod: control all hardreset lines attached to a hwmod
      ARM: OMAP4: hwmod data: remove pseudo-hwmods associated with hardreset lines
      ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are reprogrammed after a reset
      ARM: OMAP2+: hwmod: provide a function to return the address space of the MPU RT
      ARM: OMAP2+: hwmod: add omap_hwmod_get_mpu_irq() and omap_hwmod_get_mpu_rt_pa()
      ARM: OMAP2+: timer: use a proper interface to get hwmod data
      ARM: OMAP2+: hwmod: split the _setup() function


 arch/arm/mach-omap2/omap_hwmod.c             |  345 +++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  101 --------
 arch/arm/mach-omap2/timer.c                  |    8 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 
 4 files changed, 263 insertions(+), 194 deletions(-)
