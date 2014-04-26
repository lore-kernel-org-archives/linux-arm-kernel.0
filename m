From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 26 Apr 2014 10:58:59 +0100
Subject: [GIT PULL] arm64 fixes for 3.15
Message-ID: <20140426095850.GA1307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 3.15. Thanks.

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to bc3ee18a7a57243721ecfd879319e3d2e882f289:

  arm64: init: Move of_clk_init to time_init (2014-04-25 18:15:56 +0100)

----------------------------------------------------------------
- compat renameat2 syscall wiring and __NR_compat_syscalls fix
- TLB fix for transparent huge pages following switch to generic
  mmu_gather
- spinlock initialisation for init_mm's context
- move of_clk_init() earlier
- Kconfig duplicate entry fix

----------------------------------------------------------------
Chanho Min (1):
      arm64: init: Move of_clk_init to time_init

Hanjun Guo (1):
      ARM64: Remove duplicated Kconfig entry for "kernel/power/Kconfig"

Leo Yan (1):
      arm64: initialize spinlock for init_mm's context

Miklos Szeredi (2):
      arm64: __NR_compat_syscalls fix
      arm64: add renameat2 compat syscall

Steve Capper (1):
      arm64: mm: Add THP TLB entries to general mmu_gather

Will Deacon (1):
      arm64: debug: remove noisy, pointless warning

 arch/arm64/Kconfig                 | 2 --
 arch/arm64/include/asm/mmu.h       | 3 +++
 arch/arm64/include/asm/tlb.h       | 6 ++++++
 arch/arm64/include/asm/unistd32.h  | 3 ++-
 arch/arm64/kernel/debug-monitors.c | 3 ---
 arch/arm64/kernel/setup.c          | 1 -
 arch/arm64/kernel/time.c           | 2 ++
 7 files changed, 13 insertions(+), 7 deletions(-)

-- 
Catalin
