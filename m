From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Jul 2015 17:17:49 +0100
Subject: [GIT PULL] arm64 fixes/clean-up
Message-ID: <20150703161748.GA10890@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. Thanks.


The following changes since commit 86dca36e6ba019650a94cadf922ea3d06dec0182:

  arm64: use private ratelimit state along with show_unhandled_signals (2015-06-19 16:26:15 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f871d26807078cf4cc0a64a97ee2c6bb513a4397:

  arm64: Fix show_unhandled_signal_ratelimited usage (2015-07-03 17:03:06 +0100)

----------------------------------------------------------------
Various arm64 fixes:

- suspicious RCU usage warning
- BPF (out of bounds array read and endianness conversion)
- perf (of_node usage after of_node_put, cpu_pmu->plat_device
  assignment)
- huge pmd/pud check for value 0
- rate-limiting should only take unhandled signals into account

Clean-up:

- incorrect use of pgprot_t type
- unused header include
- __init annotation to arm_cpuidle_init
- pr_debug instead of pr_error for disabled GICC entries in ACPI/MADT

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: fix incorrect use of pgprot_t variable

Christoffer Dall (1):
      arm64: Don't report clear pmds and puds as huge

Hanjun Guo (1):
      ARM64 / SMP: Switch pr_err() to pr_debug() for disabled GICC entry

Jisheng Zhang (1):
      arm64: cpuidle: add __init section marker to arm_cpuidle_init

Maninder Singh (1):
      arm64/hw_breakpoint.c: remove unnecessary header

Shannon Zhao (1):
      arm64: perf: fix unassigned cpu_pmu->plat_device when probing PMU PPIs

Stephen Boyd (2):
      ARM64: smp: Fix suspicious RCU usage with ipi tracepoints
      arm64: perf: Don't use of_node after putting it

Suzuki K. Poulose (1):
      arm64: Fix show_unhandled_signal_ratelimited usage

Xi Wang (2):
      arm64: bpf: fix out-of-bounds read in bpf2a64_offset()
      arm64: bpf: fix endianness conversion bugs

 arch/arm64/kernel/cpuidle.c       |  2 +-
 arch/arm64/kernel/hw_breakpoint.c |  1 -
 arch/arm64/kernel/perf_event.c    |  6 ++++--
 arch/arm64/kernel/smp.c           | 12 ++++++------
 arch/arm64/kernel/traps.c         |  2 +-
 arch/arm64/mm/fault.c             |  2 +-
 arch/arm64/mm/hugetlbpage.c       |  4 ++--
 arch/arm64/mm/mmu.c               |  2 +-
 arch/arm64/net/bpf_jit.h          |  4 ++++
 arch/arm64/net/bpf_jit_comp.c     | 29 ++++++++++++++++++++++++-----
 10 files changed, 44 insertions(+), 20 deletions(-)

-- 
Catalin
