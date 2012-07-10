From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 06:05:56 -0700
Subject: [GIT PULL 3/5] omap cleanup part2 for v3.6 merge window
In-Reply-To: <pull-1341925556-888624>
Message-ID: <mailman.27.1341925573.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3f96a2d90e6923e2dd1e35d2f149a70a4d0f678c:

  Merge tags 'omap-cleanup-for-v3.6', 'omap-devel-dmtimer-for-v3.6' and 'omap-devel-am33xx-for-v3.6' into devel-am33xx-part2 (2012-07-04 00:29:31 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-part2-for-v3.6

for you to fetch changes up to fb584511c4664573097ece7df0de06ad00b713a2:

  ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds (2012-07-09 01:44:11 -0700)

----------------------------------------------------------------
This branch contains more clean-up like changes and minor fixes for making
it easier to support new omap SoCs, such as omap5 and am33xx.

This branch has dependencies to earlier clean-up in omap-cleanup-for-v3.6
and  omap-devel-dmtimer-for-v3.6 branches, and also depends on the
omap-devel-am33xx-for-v3.6 branch, and are based on a merge of these
branches.

----------------------------------------------------------------
Jon Hunter (2):
      ARM: OMAP4: clockdomain/CM code: Update supported transition modes
      ARM: OMAP2+: powerdomain code: Fix Wake-up power domain power status

Kishon Vijay Abraham I (1):
      ARM: OMAP2+: hwmod code: add support to set dmadisable in hwmod framework

Paul Walmsley (1):
      Merge branches 'hwmod_am335x_support_3.6', 'clkdm_pwrdm_devel_a_3.6' and 'misc_devel_3.6' into omap_devel_f_3.6

R Sricharan (1):
      ARM: OMAP2+: PRM/CM: Move the stubbed prm and cm functions to prcm.c file and make them __weak

Sakari Ailus (1):
      ARM: OMAP3: control: add definition for CONTROL_CAMERA_PHY_CTRL

Santosh Shilimkar (1):
      ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds

Tarun Kanti DebBarma (3):
      ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
      ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
      ARM: OMAP2+: dmtimer: cleanup fclk usage

Tony Lindgren (2):
      Merge tag 'omap-devel-f-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into cleanup-part2
      ARM: OMAP2+: Fix mismerge for omap_hwmod_get_main_clk() API

Vaibhav Hiremath (7):
      ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod required for am33xx
      ARM: OMAP3/4: omap_hwmod: Add rstst_offs field to struct omap_hwmod_omap4_prcm
      ARM: OMAP2+: All OMAP2PLUS uses omap-device.o target so add one entry
      ARM: OMAP2+: Move omap3 dpll ops to dpll3xxx.c
      ARM: OMAP2+: am33xx: Make am33xx as a separate class
      ARM: OMAP2+: am33xx: Change cpu_is_am33xx to soc_is_am33xx
      ARM: OMAP2+: Remove unnecessary ifdef around __omap2_set_globals

Vikram Pandita (1):
      ARM: OMAP3+: dpll: optimize noncore dpll locking logic

 arch/arm/mach-omap2/Kconfig                  |   12 +++-
 arch/arm/mach-omap2/Makefile                 |    8 ++-
 arch/arm/mach-omap2/clock.c                  |   18 ------
 arch/arm/mach-omap2/clock3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c         |   22 ++++----
 arch/arm/mach-omap2/clockdomain44xx.c        |   10 +++-
 arch/arm/mach-omap2/cminst44xx.c             |   14 -----
 arch/arm/mach-omap2/cminst44xx.h             |   25 ---------
 arch/arm/mach-omap2/common.c                 |   10 +---
 arch/arm/mach-omap2/common.h                 |    5 ++
 arch/arm/mach-omap2/control.h                |    1 +
 arch/arm/mach-omap2/dpll3xxx.c               |   26 ++++++++-
 arch/arm/mach-omap2/id.c                     |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   76 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   10 ++++
 arch/arm/mach-omap2/powerdomain.c            |    6 +-
 arch/arm/mach-omap2/prcm.c                   |   23 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |   65 ----------------------
 arch/arm/mach-omap2/prm_common.c             |   62 +++++++++++++++++++++
 arch/arm/mach-omap2/timer.c                  |    3 +-
 arch/arm/plat-omap/Makefile                  |    4 +-
 arch/arm/plat-omap/dmtimer.c                 |   53 ++++++------------
 arch/arm/plat-omap/include/plat/cpu.h        |   17 +++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   19 +++++++
 arch/arm/plat-omap/include/plat/sdrc.h       |    2 +-
 arch/arm/plat-omap/sram.c                    |    6 +-
 26 files changed, 296 insertions(+), 207 deletions(-)
