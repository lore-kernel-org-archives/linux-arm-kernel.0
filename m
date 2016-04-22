From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:17:19 +0100
Subject: [GIT PULL] arm64 fixes for 4.6-rc5
Message-ID: <20160422131716.GA23317@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 882416c1e4d1c9d4c7b50e0f5c3fa9ef043cd710:

  arm64: Fix EL1/EL2 early init inconsistencies with VHE (2016-04-21 18:34:23 +0100)

----------------------------------------------------------------
arm64 fixes:

- Cache invalidation fix for early CPU boot status update (incorrect
  cacheline)

- of_put_node() missing in the spin_table code

- EL1/El2 early init inconsistency when Virtualisation Host Extensions
  are present

- RCU warning fix in the arm_pmu.c driver

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: fix invalidation of wrong __early_cpu_boot_status cacheline

Dave Martin (1):
      arm64: Fix EL1/EL2 early init inconsistencies with VHE

Lorenzo Pieralisi (1):
      drivers/perf: arm-pmu: fix RCU usage on pmu resume from low-power

Masahiro Yamada (1):
      arm64: spin-table: add missing of_node_put()

 arch/arm64/kernel/head.S           | 13 ++++++++++++-
 arch/arm64/kernel/smp_spin_table.c | 11 ++++++-----
 drivers/perf/arm_pmu.c             | 15 +++++++++++++--
 3 files changed, 31 insertions(+), 8 deletions(-)

-- 
Catalin
