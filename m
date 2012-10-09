From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Oct 2012 11:46:27 -0700
Subject: [GIT PULL 4/5] omap cpufreq fixes for v3.7-rc1
In-Reply-To: <pull-1349808387-617119>
Message-ID: <mailman.21.1349808410.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5e090ed7af10729a396a25df43d69a236e789736:

  Merge tag 'soc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-10-07 20:55:16 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-cpufreq-signed

for you to fetch changes up to 37fedb4c423ab78639e65a7c15d2f23cb412aa7e:

  Merge tag 'for_3.7-fixes-cpufreq' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-cpufreq (2012-10-08 15:54:14 -0700)

----------------------------------------------------------------

These were agreed to be merged via arm soc tree as Rafael
is on vacation.

>From Kevin Hilman <khilman@deeprootsystems.com>:

This series a couple bug fixes and a couple fixes that make this
driver support recently added OMAP-based SoCs.

The 'get_cpu_device' patch is needed due to a change in the OMAP
OMAP PM core code which enforces use of get_cpu_device() instead of
a deprecated OMAP-specific API.

The usage of plat/*.h headers breaks single zImage, so platforms are
cleaning up and/or removing plat/*.h so the driver needs to be fixed
accordingly.

This series is based on the merge of Rafael's pm-for-3.7-rc1 tag into
Linus' master branch: commit 16642a2e7be23bbda013fc32d8f6c68982eab603.

----------------------------------------------------------------
Kevin Hilman (4):
      cpufreq: OMAP: ensure valid clock rate before scaling
      cpufreq: OMAP: remove unused <plat/omap-pm.h>
      cpufreq: OMAP: use get_cpu_device() instead of omap_device API
      ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS

Paul Walmsley (1):
      cpufreq: OMAP: fix clock usage to be SoC independent, remove plat/ includes

Tony Lindgren (1):
      Merge tag 'for_3.7-fixes-cpufreq' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-cpufreq

 arch/arm/mach-omap2/opp.c        |   23 +++++++++++++++++------
 arch/arm/mach-omap2/pm.c         |   11 ++++++++++-
 arch/arm/mach-omap2/twl-common.c |    2 +-
 drivers/cpufreq/omap-cpufreq.c   |   36 ++++++++++++------------------------
 4 files changed, 40 insertions(+), 32 deletions(-)
