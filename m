From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 May 2012 11:03:47 -0700
Subject: [GIT PULL] ARM: OMAP: PM: CPUidle cleanup for v3.5
Message-ID: <87d36f50n0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following cleanup/consolidation of the OMAP CPUidle
code.  It's been reviewed and tested by Jean, Santosh and myself on
OMAP3/4.

Special thanks to Daniel Lezcano for this nice cleanup and
consolidation.

Kevin


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/cleanup/omap-cpuidle

for you to fetch changes up to daa37cee791722711bf15b9635d007014e73ad3d:

  ARM: OMAP3: cpuidle - check the powerdomain lookup (2012-05-04 14:07:10 -0700)

----------------------------------------------------------------
Daniel Lezcano (18):
      ARM: OMAP4: cpuidle - Remove unused valid field
      ARM: OMAP4: cpuidle - Declare the states with the driver declaration
      ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
      ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
      ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
      ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
      ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot time
      ARM: OMAP3: cpuidle - remove rx51 cpuidle parameters table
      ARM: OMAP3: define cpuidle statically
      ARM: OMAP3: cpuidle - remove errata check in the init function
      ARM: OMAP3: cpuidle - remove the 'valid' field
      ARM: OMAP3: cpuidle - remove cpuidle_params_table
      ARM: OMAP3: define statically the omap3_idle_data
      ARM: OMAP3: cpuidle - use omap3_idle_data directly
      ARM: OMAP3: cpuidle - simplify next_valid_state
      ARM: OMAP3: set omap3_idle_data as static
      ARM: OMAP3: cpuidle - set global variables static
      ARM: OMAP3: cpuidle - check the powerdomain lookup

 arch/arm/mach-omap2/board-rx51.c  |   38 +++--
 arch/arm/mach-omap2/cpuidle34xx.c |  298 +++++++++++++++----------------------
 arch/arm/mach-omap2/cpuidle44xx.c |  126 +++++++---------
 arch/arm/mach-omap2/pm.h          |   21 ---
 4 files changed, 190 insertions(+), 293 deletions(-)
