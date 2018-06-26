From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 12:00:09 +0100
Subject: [PATCH 0/3] Hook up qspinlock for arm64
Message-ID: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everybody,

With my recent changes to the core qspinlock code, it now performs well
enough on arm64 to replace our ticket-based approach.

Testing welcome,

Will

--->8

Will Deacon (3):
  arm64: barrier: Implement smp_cond_load_relaxed
  arm64: locking: Replace ticket lock implementation with qspinlock
  arm64: kconfig: Ensure spinlock fastpaths are inlined if !PREEMPT

 arch/arm64/Kconfig                      |  11 +++
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/barrier.h        |  13 ++++
 arch/arm64/include/asm/spinlock.h       | 117 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |  17 +----
 5 files changed, 27 insertions(+), 132 deletions(-)

-- 
2.1.4
