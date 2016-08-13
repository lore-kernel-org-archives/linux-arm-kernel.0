From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Aug 2016 23:27:32 +0100
Subject: [GIT PULL] arm64 fixes for 4.8-rc2
Message-ID: <20160813222728.GA12077@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 4.8-rcX. Thanks.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 53fb45d3df6fb64eff6c314b3fa2e279a2496e5b:

  arm64: defconfig: enable CONFIG_LOCALVERSION_AUTO (2016-08-12 19:08:48 +0100)

----------------------------------------------------------------
arm64 fixes:

- Support for nr_cpus= command line argument (maxcpus was previously
  changed to allow secondary CPUs to be hot-plugged)

- ARM PMU interrupt handling fix

- Fix potential TLB conflict in the hibernate code

- Improved handling of EL1 instruction aborts (better error reporting)

- Removal of useless jprobes code for stack saving/restoring

- defconfig updates

----------------------------------------------------------------
David A. Long (1):
      arm64: Remove stack duplicating code from jprobes

Kefeng Wang (1):
      arm64: Support hard limit of cpu count by nr_cpus

Laura Abbott (1):
      arm64: Handle el1 synchronous instruction aborts cleanly

Marc Zyngier (1):
      drivers/perf: arm-pmu: Fix handling of SPI lacking "interrupt-affinity" property

Mark Rutland (2):
      arm64: hibernate: avoid potential TLB conflict
      arm64: hibernate: handle allocation failures

Masahiro Yamada (1):
      arm64: defconfig: enable CONFIG_LOCALVERSION_AUTO

Riku Voipio (1):
      arm64: defconfig: add options for virtualization and containers

Sudeep Holla (1):
      drivers/perf: arm-pmu: convert arm_pmu_mutex to spinlock

 arch/arm64/configs/defconfig       | 53 ++++++++++++++++++++----
 arch/arm64/include/asm/kprobes.h   |  2 -
 arch/arm64/kernel/entry.S          |  7 ++++
 arch/arm64/kernel/hibernate.c      | 82 +++++++++++++++++++++++---------------
 arch/arm64/kernel/probes/kprobes.c | 31 +++-----------
 arch/arm64/kernel/smp.c            |  8 ++--
 arch/arm64/mm/fault.c              | 14 ++++++-
 drivers/perf/arm_pmu.c             | 25 ++++++------
 8 files changed, 136 insertions(+), 86 deletions(-)

-- 
Catalin
