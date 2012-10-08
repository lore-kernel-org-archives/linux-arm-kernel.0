From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 08 Oct 2012 15:22:46 -0700
Subject: [GIT PULL] ARM: OMAP: CPUfreq fixes for v3.7-rc
Message-ID: <878vbg8uyx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 16642a2e7be23bbda013fc32d8f6c68982eab603:

  Merge tag 'pm-for-3.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2012-10-02 18:32:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-fixes-cpufreq

for you to fetch changes up to 24d7b40a60cf19008334bcbcbd98da374d4d9c64:

  ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS (2012-10-08 14:59:04 -0700)

----------------------------------------------------------------
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

 arch/arm/mach-omap2/opp.c        |   23 +++++++++++++++++------
 arch/arm/mach-omap2/pm.c         |   11 ++++++++++-
 arch/arm/mach-omap2/twl-common.c |    2 +-
 drivers/cpufreq/omap-cpufreq.c   |   36 ++++++++++++------------------------
 4 files changed, 40 insertions(+), 32 deletions(-)
