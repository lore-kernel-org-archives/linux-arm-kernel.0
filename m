From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:34 +0200
Subject: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Message-ID: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes some cleanup on these cpuidle drivers
and consolidate the code across both architecture.

Tested on OMAP3 (igepV2).
Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

V2 : Fixed a couple of typos in the patch description

V1 : Initial Post

Daniel Lezcano (17):
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
  ARM: OMAP3: cpuidle - remove the 'valid' field
  ARM: OMAP3: cpuidle - remove cpuidle_params_table
  ARM: OMAP3: define statically the omap3_idle_data
  ARM: OMAP3: cpuidle - use omap3_idle_data directly
  ARM: OMAP3 : cpuidle - simplify next_valid_state
  ARM: OMAP3: set omap3_idle_data as static
  ARM: OMAP3/4: consolidate cpuidle Makefile
  ARM: OMAP3: cpuidle - set global variables static

 arch/arm/mach-omap2/Makefile      |   11 +-
 arch/arm/mach-omap2/board-rx51.c  |   38 +++---
 arch/arm/mach-omap2/cpuidle34xx.c |  299 +++++++++++++++----------------------
 arch/arm/mach-omap2/cpuidle44xx.c |  135 +++++++----------
 arch/arm/mach-omap2/pm.h          |   38 ++---
 5 files changed, 219 insertions(+), 302 deletions(-)

-- 
1.7.5.4
