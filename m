From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Jun 2015 17:27:26 +0530
Subject: [PATCH 00/10] OPP: Add code to support operating-points-v2 bindings
Message-ID: <cover.1434369079.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This adds code to support operating-points-v2 bindings. Not everything
is supported yet, but most of the basic stuff is.

Tested with: Exynos 5250, dual cortex A15 board. With both old and new
bindings.

Bindings are already frozen:
http://marc.info/?i=cover.1433434659.git.viresh.kumar%40linaro.org

Pushed here as well for reference:
ssh://git at git.linaro.org/people/viresh.kumar/linux.git opp/v2

Viresh Kumar (10):
  opp: Relocate few routines
  OPP: Create _remove_device_opp() for freeing dev_opp
  OPP: Allocate dev_opp from _add_device_opp()
  OPP: Break _opp_add_dynamic() into smaller functions
  opp: Add support to parse "operating-points-v2" bindings
  OPP: Add clock-latency-ns support
  opp: Add OPP sharing information to OPP library
  OPP: Add support for opp-suspend
  opp: Add helpers for initializing CPU OPPs
  cpufreq-dt: Add support for operating-points-v2 bindings

 drivers/base/power/opp.c     | 1063 ++++++++++++++++++++++++++++++++----------
 drivers/cpufreq/cpufreq-dt.c |   58 ++-
 include/linux/pm_opp.h       |   29 ++
 3 files changed, 902 insertions(+), 248 deletions(-)

-- 
2.4.0
