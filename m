From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 7 Nov 2012 12:42:59 -0600
Subject: [PATCH 0/3] ARM: OMAP4: Clock fixes
Message-ID: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes included, fixing up timer clock aliases for v3.8 and working
around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).

Testing includes:
- Boot testing on OMAP3430 Beagle, OMAP4430 Panda and OMAP4460 Panda
- Boot tested with device-tree on OMAP4430 Panda and OMAP4460 Panda
  and validated that all timers are working.
- Suspend testing on OMAP3430 Beagle and OMAP4430 Panda (suspend not
  functional on OMAP4460 Panda prior to this series and so could not
  be tested).
- Core retention validated on OMAP3430 Beagle.

Jon Hunter (3):
  ARM: OMAP4: Update timer clock aliases
  ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
  ARM: OMAP4460: Workaround ABE DPLL failing to turn-on

 arch/arm/mach-omap2/clock44xx_data.c    |   32 ++++++++++++++--
 arch/arm/mach-omap2/dpll3xxx.c          |   46 +++++++++++++++-------
 arch/arm/mach-omap2/dpll44xx.c          |   63 ++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/clock.h |   10 +++++
 4 files changed, 124 insertions(+), 27 deletions(-)

-- 
1.7.9.5
