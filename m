From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Mar 2013 11:44:04 -0700
Subject: [GIT PULL] omap fixes for v3.9-rc4
Message-ID: <20130327184404.GD10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc3/fixes-signed

for you to fetch changes up to ff931c821bab6713a52b768b0cd7ee7e90713b36:

  ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized (2013-03-26 22:06:20 -0700)

----------------------------------------------------------------
A clock regression fix that happened with the common clock
conversion, and few USB regression fixes.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix USB host on 1710

Grazvydas Ignotas (1):
      ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb

Jon Hunter (1):
      ARM: OMAP4: clock data: lock USB DPLL on boot

Paul Walmsley (1):
      ARM: OMAP4: PM: fix PM regression introduced by recent clock cleanup

Rajendra Nayak (1):
      ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized

Tony Lindgren (1):
      Merge tag 'omap-fixes-a-for-3.9-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9-rc3/fixes

 arch/arm/mach-omap1/clock_data.c           | 12 +-----------
 arch/arm/mach-omap2/cclock44xx_data.c      | 20 ++++++++++++++++++++
 arch/arm/mach-omap2/common.h               |  3 +++
 arch/arm/mach-omap2/io.c                   | 18 ++++++++++++------
 arch/arm/mach-omap2/omap_hwmod.c           |  7 +++++--
 arch/arm/mach-omap2/omap_hwmod.h           |  9 +++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  6 ++++++
 arch/arm/mach-omap2/timer.c                |  4 ++++
 9 files changed, 64 insertions(+), 22 deletions(-)
