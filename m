From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2011 15:55:42 -0800
Subject: [GIT PULL] DSS fixes for v3.2-rc2
Message-ID: <20111123235542.GL31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This one has been separated out from the rest of the fixes.

If some of these need to go to stable, then Tomi should
do the rebasing and send them to stable at vger.kernel.org
as they don't apply cleanly on v3.1.

Regards,

Tony


The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
  Linus Torvalds (1):
        Linux 3.2-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-dss

Archit Taneja (1):
      ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in bootloader

Tomi Valkeinen (9):
      ARM: OMAP2xxx: HWMOD: Fix DSS reset
      ARM: OMAP2xxx: HWMOD: fix DSS clock data
      ARM: OMAP3: HWMOD: Fix DSS reset
      ARM: OMAP3: HWMOD: fix DSS clock data
      ARM: OMAP4: HWMOD: remove extra clocks
      ARM: OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
      ARM: OMAP4: HWMOD: fix DSS clock data
      ARM: OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      ARM: OMAP: HWMOD: Unify DSS resets for OMAPs

Tony Lindgren (1):
      Merge branch 'hwmod_dss_fixes_3.2rc' of git://git.pwsan.com/linux-2.6 into fixes-dss

 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/display.c                      |  159 ++++++++++++++++++++
 arch/arm/mach-omap2/display.h                      |   29 ++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   17 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   17 ++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   37 ++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   24 ++--
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    4 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
 arch/arm/plat-omap/include/plat/common.h           |    3 +
 include/video/omapdss.h                            |    7 -
 12 files changed, 276 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.h
