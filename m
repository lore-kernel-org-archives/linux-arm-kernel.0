From: Catalin.Marinas@arm.com (Catalin Marinas)
Date: Fri, 17 May 2013 18:32:05 +0100
Subject: [GIT PULL] arm64 fixes for 3.10-rc2
Message-ID: <20130517173205.GA14326@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. Thanks.

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-fixes

for you to fetch changes up to 3126976be64bfb4c87297cb022ca815212079aec:

  arm64: debug: fix mdscr.ss check when enabling debug exceptions (2013-05-17 18:24:19 +0100)

----------------------------------------------------------------
Fixes for duplicate definition of early_console, kernel/time/Kconfig
include, __flush_dcache_all() set/way computing, debug (locking, bit
testing). The of_platform_populate() was moved to an arch_init_call() to
allow subsys_init_call() drivers to probe the DT.

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Invoke the of_platform_populate() at arch_initcall() level
      arm64: Do not source kernel/time/Kconfig explicitly

Chen Gang (1):
      arm64: Fix duplicate definition of early_console

Sukanto Ghosh (1):
      arm64: mm: Fix operands of clz in __flush_dcache_all

Will Deacon (2):
      arm64: debug: clear mdscr_el1 instead of taking the OS lock
      arm64: debug: fix mdscr.ss check when enabling debug exceptions

 arch/arm64/Kconfig                 |  2 --
 arch/arm64/include/asm/assembler.h |  2 +-
 arch/arm64/kernel/debug-monitors.c |  2 --
 arch/arm64/kernel/early_printk.c   |  5 +++--
 arch/arm64/kernel/setup.c          | 12 +++---------
 arch/arm64/mm/cache.S              |  2 +-
 arch/arm64/mm/proc.S               |  3 +--
 7 files changed, 9 insertions(+), 19 deletions(-)
