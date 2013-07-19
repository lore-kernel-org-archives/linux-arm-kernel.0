From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Jul 2013 17:03:50 +0100
Subject: [GIT PULL] arm64 fixes for 3.11-rc2
Message-ID: <20130719160336.GA22565@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to ff701306cd49aaff80fb852323b387812bc76491:

  arm64: use common reboot infrastructure (2013-07-19 15:57:08 +0100)

----------------------------------------------------------------
- Post -rc1 update to the common reboot infrastructure.
- Fixes (user cache maintenance fault handling, !COMPAT compilation, CPU
  online and interrupt hanlding).

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Only enable local interrupts after the CPU is marked online

Chen Gang (1):
      arm64: add '#ifdef CONFIG_COMPAT' for aarch32_break_handler()

Marc Zyngier (1):
      arm64: use common reboot infrastructure

Will Deacon (1):
      arm64: mm: don't treat user cache maintenance faults as writes

 arch/arm64/include/asm/debug-monitors.h |  7 -----
 arch/arm64/include/asm/system_misc.h    |  3 ++-
 arch/arm64/kernel/process.c             |  2 +-
 arch/arm64/kernel/smp.c                 | 15 ++++++-----
 arch/arm64/mm/fault.c                   | 46 ++++++++++++++-------------------
 5 files changed, 31 insertions(+), 42 deletions(-)

-- 
Catalin
