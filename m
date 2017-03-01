From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Mar 2017 04:51:56 +0000
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20170301045156.GD12637@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these three arm64 fixes for -rc1. The main fix here addresses a
kernel panic triggered on Qualcomm QDF2400 due to incorrect register usage
in an erratum workaround introduced during the merge window.

Cheers,

Will

--->8

The following changes since commit ffe7afd1713558d73483834c2e2d03a1e39a4062:

  arm64/kprobes: consistently handle MRS/MSR with XZR (2017-02-15 12:20:29 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 638f863dbbc8da16834ee0acc6ac10754f79c486:

  arm64/cpufeature: check correct field width when updating sys_val (2017-02-24 11:14:12 +0000)

----------------------------------------------------------------
- Fix kernel panic on specific Qualcomm platform due to broken erratum
  workaround
- Revert contiguous bit support due to TLB conflict aborts in simulation
- Don't treat all CPU ID register fields as 4-bit quantities

----------------------------------------------------------------
Mark Rutland (2):
      Revert "arm64: mm: set the contiguous bit for kernel mappings where appropriate"
      arm64/cpufeature: check correct field width when updating sys_val

Shanker Donthineni (1):
      arm64: Avoid clobbering mm in erratum workaround on QDF2400

 arch/arm64/include/asm/cpufeature.h | 14 ++++++++++----
 arch/arm64/mm/mmu.c                 | 34 ++++------------------------------
 arch/arm64/mm/proc.S                |  2 +-
 3 files changed, 15 insertions(+), 35 deletions(-)
