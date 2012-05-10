From: r.sricharan@ti.com (R Sricharan)
Date: Thu, 10 May 2012 22:36:51 +0530
Subject: [PATCH 0/4] ARM: OMAP2+: Misc cleanup part2
Message-ID: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a continuation of the previous cleanup series from
santosh.shilimkar at ti.com [1]. Patches are outcome of the OMAP5
review suggestions from Tony/Benoit/Santosh/Rajendra. 

[1]  http://www.spinics.net/lists/linux-omap/msg69730.html

R Sricharan (4):
  ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
  ARM: OMAP2+: Move the stubbed prm and cm functions to prcm.c file and
    make them __weak.
  ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c
    and call it __weak
  ARM: OMAP: counter-32k: Select the CR register offset using the IP
    scheme.

 arch/arm/mach-omap2/Kconfig                   |    5 ++
 arch/arm/mach-omap2/clock.c                   |    2 +-
 arch/arm/mach-omap2/cminst44xx.h              |   25 --------
 arch/arm/mach-omap2/prcm.c                    |   77 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |   65 ---------------------
 arch/arm/plat-omap/common.c                   |    9 +++
 arch/arm/plat-omap/counter_32k.c              |   16 ++++-
 arch/arm/plat-omap/include/plat/clock.h       |    4 +-
 arch/arm/plat-omap/include/plat/omap-secure.h |    5 --
 9 files changed, 107 insertions(+), 101 deletions(-)
