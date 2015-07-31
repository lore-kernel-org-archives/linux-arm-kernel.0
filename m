From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Jul 2015 16:23:59 +0100
Subject: [GIT PULL] ARM perf updates for 4.3
Message-ID: <20150731152359.GK29497@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull the following ARM perf updates for 4.3?
The main changes include:

  * Support for describing cluster-affine PPIs, which will likely be
    needed by some future big.LITTLE platforms with heterogeneous PMUs

  * Moving the bulk of the driver out to drivers/perf, so that it can be
    re-used by arm64 (I'll probably send that patch at -rc1).

Cheers,

Will

--->8

The following changes since commit 8e0c34b0d268f10d84cb3f79f59c140d545a553a:

  ARM: 8402/1: perf: Don't use of_node after putting it (2015-07-17 15:08:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to fa8ad7889d83bcf0a6cdbf6d3622f3ec019cde14:

  arm: perf: factor arm_pmu core out to drivers (2015-07-31 15:01:14 +0100)

----------------------------------------------------------------
Mark Rutland (1):
      arm: perf: factor arm_pmu core out to drivers

Stephen Boyd (1):
      arm: perf: Set affinity for PPI based PMUs

Sudeep Holla (1):
      ARM: perf: replace arch_find_n_match_cpu_physical_id with of_cpu_device_node_get

Will Deacon (1):
      ARM: perf: extend interrupt-affinity property for PPIs

 Documentation/devicetree/bindings/arm/pmu.txt      | 12 +++-
 MAINTAINERS                                        |  6 +-
 arch/arm/Kconfig                                   |  8 +--
 arch/arm/kernel/Makefile                           |  3 +-
 arch/arm/kernel/perf_event_v6.c                    |  2 +-
 arch/arm/kernel/perf_event_v7.c                    |  2 +-
 arch/arm/kernel/perf_event_xscale.c                |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  2 +-
 drivers/Kconfig                                    |  2 +
 drivers/Makefile                                   |  1 +
 drivers/perf/Kconfig                               | 15 +++++
 drivers/perf/Makefile                              |  1 +
 .../kernel/perf_event.c => drivers/perf/arm_pmu.c  | 69 +++++++++++++++-------
 .../asm/pmu.h => include/linux/perf/arm_pmu.h      |  4 +-
 14 files changed, 88 insertions(+), 41 deletions(-)
 create mode 100644 drivers/perf/Kconfig
 create mode 100644 drivers/perf/Makefile
 rename arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c (94%)
 rename arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h (98%)
