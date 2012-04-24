From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Apr 2012 16:05:21 +0200
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Message-ID: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes some cleanup on these cpuidle drivers
and consolidate the code across both architecture.

Tested on OMAP3 (igepV2).
Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

V3 :
   * replace OMAP4_NUM_STATES and OMAP3_NUM_STATES by ARRAY_SIZE
   * Fixed changelog
   * Fixed OMAP4_NUM_STATES going back and forth in the patchset
   * Removed erratum check at init time

V2 :
   * Fixed a couple of typos in the patch description

V1 : Initial Post

Daniel Lezcano (18):
  ARM: OMAP4: cpuidle - Remove unused valid field
  ARM: OMAP4: cpuidle - Declare the states with the driver declaration
  ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
  ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
  ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
  ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
  ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
    time
  ARM: OMAP3: cpuidle - remove rx51 cpuidle parameters table
  ARM: OMAP3: define cpuidle statically
  ARM: OMAP3: cpuidle - remove errata check in the init function
  ARM: OMAP3: cpuidle - remove the 'valid' field
  ARM: OMAP3: cpuidle - remove cpuidle_params_table
  ARM: OMAP3: define statically the omap3_idle_data
  ARM: OMAP3: cpuidle - use omap3_idle_data directly
  ARM: OMAP3: cpuidle - simplify next_valid_state
  ARM: OMAP3: set omap3_idle_data as static
  ARM: OMAP3/4: consolidate cpuidle Makefile
  ARM: OMAP3: cpuidle - set global variables static

 arch/arm/mach-omap2/Makefile      |   11 +-
 arch/arm/mach-omap2/board-rx51.c  |   38 +++---
 arch/arm/mach-omap2/cpuidle34xx.c |  306 +++++++++++++++----------------------
 arch/arm/mach-omap2/cpuidle44xx.c |  134 +++++++----------
 arch/arm/mach-omap2/pm.h          |   38 ++---
 5 files changed, 212 insertions(+), 315 deletions(-)

-- 
1.7.5.4
