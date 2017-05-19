From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 May 2017 14:48:50 +0100
Subject: [GIT PULL] arm64 fixes for 4.12
Message-ID: <20170519134846.GA21800@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 63a1e1c95e60e798fa09ab3c536fb555aa5bbf2b:

  arm64/cpufeature: don't use mutex in bringup path (2017-05-17 17:00:29 +0100)

----------------------------------------------------------------
arm64 fixes/cleanups:

- Avoid taking a mutex in the secondary CPU bring-up path when
  interrupts are disabled

- Ignore perf exclude_hv when the kernel is running in Hyp mode

- Remove redundant instruction in cmpxchg

----------------------------------------------------------------
Ganapatrao Kulkarni (1):
      arm64: perf: Ignore exclude_hv when kernel is running in HYP

Mark Rutland (1):
      arm64/cpufeature: don't use mutex in bringup path

Robin Murphy (1):
      arm64: Remove redundant mov from LL/SC cmpxchg

 arch/arm64/include/asm/atomic_ll_sc.h |  1 -
 arch/arm64/include/asm/cpufeature.h   | 12 ++++++++++--
 arch/arm64/include/asm/kvm_host.h     |  8 ++++++--
 arch/arm64/kernel/cpufeature.c        | 23 +++++++++++++++++++++--
 arch/arm64/kernel/perf_event.c        | 23 ++++++++++++++++-------
 5 files changed, 53 insertions(+), 14 deletions(-)

-- 
Catalin
