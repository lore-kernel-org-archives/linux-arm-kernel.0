From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  3 Oct 2012 16:00:25 -0700
Subject: [PATCH 0/4] cpufreq: OMAP: fixes for v3.7-rc2
Message-ID: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

Here's a series with a couple bug fixes and a couple fixes that
make this driver support newer OMAP-based SoCs.

The 'get_cpu_device' patch is needed due to a change in the OMAP
OMAP PM core code which enforces use of get_cpu_device() instead of
a deprecated OMAP-specific API.

The usage of plat/*.h headers breaks single zImage, so platforms are
cleaning up and/or removing plat/*.h so the driver needs to be fixed
accordingly.

This series is based on the merge of Rafael's pm-for-3.7-rc1 tag into
Linus' master branch: commit 16642a2e7be23bbda013fc32d8f6c68982eab603.

Tested CPUfreq on OMAP platforms: 3430/n900, 3530/Overo,
3730/OveroSTORM, 3730/Beagle-XM, 4430/Panda.

Rafael, if you're OK with this series, I'll get a pull request
ASAP so it can be included for v3.7-rc2.

Kevin Hilman (3):
  cpufreq: OMAP: ensure valid clock rate before scaling
  cpufreq: OMAP: remove unused <plat/omap-pm.h>
  cpufreq: OMAP: use get_cpu_device() instead of omap_device API

Paul Walmsley (1):
  cpufreq: OMAP: fix clock usage to be SoC independent, remove plat/
    includes

 drivers/cpufreq/omap-cpufreq.c |   36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

-- 
1.7.9.2
