From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Dec 2017 18:23:35 +0000
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20171201182335.GF8826@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.15-rc2. The critical one here
is a fix for fpsimd register corruption across signals which was introduced
by the SVE support code (the register files overlap), but the others are
worth having as well.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3a33c7605750fb6a87613044d16b1455e482414d:

  arm64: context: Fix comments and remove pointless smp_wmb() (2017-12-01 13:05:08 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix FP register corruption when SVE is not available or in use

- Fix out-of-tree module build failure when CONFIG_ARM64_MODULE_PLTS=y

- Missing 'const' generating errors with LTO builds

- Remove unsupported events from Cortex-A73 PMU description

- Removal of stale and incorrect comments

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: module-plts: factor out PLT generation code for ftrace
      arm64: ftrace: emit ftrace-mod.o contents through code

Dave Martin (1):
      arm64: fpsimd: Fix failure to restore FPSIMD state after signals

Jinbum Park (1):
      arm64: pgd: Mark pgd_cache as __ro_after_init

Mark Rutland (1):
      arm64: mm: cleanup stale AIVIVT references

Will Deacon (1):
      arm64: context: Fix comments and remove pointless smp_wmb()

Xu YiPing (1):
      arm64: perf: remove unsupported events for Cortex-A73

Yury Norov (1):
      arm64: cpu_ops: Add missing 'const' qualifiers

 arch/arm64/Makefile                 |  3 ---
 arch/arm64/include/asm/cacheflush.h |  2 +-
 arch/arm64/include/asm/module.h     | 46 +++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/Makefile          |  3 ---
 arch/arm64/kernel/cpu_ops.c         |  6 ++---
 arch/arm64/kernel/fpsimd.c          |  6 ++---
 arch/arm64/kernel/ftrace-mod.S      | 18 -------------
 arch/arm64/kernel/ftrace.c          | 14 ++++++-----
 arch/arm64/kernel/module-plts.c     | 50 +++++++++++--------------------------
 arch/arm64/kernel/module.lds        |  1 +
 arch/arm64/kernel/perf_event.c      |  6 -----
 arch/arm64/mm/context.c             | 28 ++++++++++++---------
 arch/arm64/mm/pgd.c                 |  2 +-
 13 files changed, 92 insertions(+), 93 deletions(-)
 delete mode 100644 arch/arm64/kernel/ftrace-mod.S
