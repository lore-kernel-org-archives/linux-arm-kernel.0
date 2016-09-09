From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Sep 2016 18:32:51 +0100
Subject: [GIT PULL] arm64 fixes for 4.8-rc6
Message-ID: <20160909173248.GA13922@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 2b9743441a312e0b0a2d87deae363eccbe9d0f00:

  arm64: use preempt_disable_notrace in _percpu_read/write (2016-09-09 12:34:47 +0100)

----------------------------------------------------------------
- smp_mb__before_spinlock() changed to smp_mb() on arm64 since the
  generic definition to smp_wmb() is not sufficient

- avoid a recursive loop with the graph tracer by using using
  preempt_(enable|disable)_notrace in _percpu_(read|write)

----------------------------------------------------------------
Chunyan Zhang (1):
      arm64: use preempt_disable_notrace in _percpu_read/write

Will Deacon (1):
      arm64: spinlocks: implement smp_mb__before_spinlock() as smp_mb()

 arch/arm64/include/asm/percpu.h   |  8 ++++----
 arch/arm64/include/asm/spinlock.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
Catalin
