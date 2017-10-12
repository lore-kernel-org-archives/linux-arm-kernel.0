From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Oct 2017 13:20:46 +0100
Subject: [PATCH v3 0/5] Switch arm64 over to qrwlock
Message-ID: <1507810851-306-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version three of the patches previously posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534981.html

Changes since v2 include:

  * Drop unused cnt argument
  * Fix typo in UNLOCK Kconfig inlining options
  * Added Tested-by tags

Thanks to all of those who provided review and testing feedback!

Will

--->8

Will Deacon (5):
  kernel/locking: Use struct qrwlock instead of struct __qrwlock
  locking/atomic: Add atomic_cond_read_acquire
  kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
  arm64: locking: Move rwlock implementation over to qrwlocks
  kernel/locking: Prevent slowpath writers getting held up by fastpath

 arch/arm64/Kconfig                      |  17 ++++
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |   6 +-
 include/asm-generic/atomic-long.h       |   3 +
 include/asm-generic/qrwlock.h           |  37 ++-----
 include/asm-generic/qrwlock_types.h     |  15 ++-
 include/linux/atomic.h                  |   4 +
 kernel/locking/qrwlock.c                |  86 +++--------------
 9 files changed, 61 insertions(+), 272 deletions(-)

-- 
2.1.4
