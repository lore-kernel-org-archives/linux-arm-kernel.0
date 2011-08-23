From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Aug 2011 23:35:53 -0600 (MDT)
Subject: [GIT PULL] OMAP: clock/powerdomain/clockdomain/hwmod: fixes for 3.1-rc
Message-ID: <alpine.DEB.2.00.1108222319310.28226@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 prcm-fixes-a-3.1rc

Note that for these changes to boot successfully on 3.1-rc3, the following 
patch is needed:

  http://marc.info/?l=linux-omap&m=131407622527432&w=2

The changes have been boot-tested on N800, OMAP3530 Beagle, and 
OMAP4430ES2 Panda.  They've also passed compile tests with a few different 
configs here.

Paul Walmsley (4):
      OMAP4: clock: re-enable previous clockdomain enable/disable sequence
      OMAP4: clock: fix compile warning
      OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in the WKUP clockdomain
      Merge branches 'pwrdm_clkdm_fixes_3.1rc', 'omap2_3_hwmod_dss_fixes_3.1rc', 'non_hwmod_compliant_fix_3.1rc', 'omap4_clock_fixes_3.1rc' and 'omap3_clock_fixes_3.1rc' into prcm-fixes-a-3.1rc

Rajendra Nayak (1):
      OMAP: powerdomains: Make all powerdomain target states as ON at init

Santosh Shilimkar (1):
      OMAP: clockdomain: Wait for powerdomain to be ON when using clockdomain force wakeup

Tomi Valkeinen (5):
      OMAP2xxx: HWMOD: fix DSS opt clocks
      OMAP3: HWMOD: fix DSS opt clocks
      OMAP4: HWMOD: fix DSS opt clocks
      OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      OMAP: HWMOD: Unify DSS resets for all OMAPs

 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/clock3xxx_data.c               |    2 +
 arch/arm/mach-omap2/clock44xx_data.c               |   10 +++++-
 arch/arm/mach-omap2/clockdomain.c                  |    2 +
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 +++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   19 ++++-------
 arch/arm/mach-omap2/pm.c                           |    2 -
 arch/arm/mach-omap2/powerdomain.c                  |   25 +++++++++-----
 arch/arm/plat-omap/include/plat/common.h           |    3 ++
 include/video/omapdss.h                            |    7 ----
 14 files changed, 136 insertions(+), 44 deletions(-)
