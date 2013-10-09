From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Oct 2013 15:54:25 +0100
Subject: [PATCH 0/3] arm64: spinlock and lockref updates for 3.13
Message-ID: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds a ticket-lock implementation for arm64, and then
builds on top of this to implement the lockless lockref implementation
in a very similar fashion to what I previously posted for ARM.

All feedback welcome,

Will


Will Deacon (3):
  arm64: locks: introduce ticket-based spinlock implementation
  arm64: lockref: add support for lockless lockrefs using cmpxchg
  arm64: cmpxchg: implement cmpxchg64_relaxed

 arch/arm64/Kconfig                      |  1 +
 arch/arm64/include/asm/cmpxchg.h        |  2 +
 arch/arm64/include/asm/spinlock.h       | 83 ++++++++++++++++++++++-----------
 arch/arm64/include/asm/spinlock_types.h | 10 ++--
 4 files changed, 65 insertions(+), 31 deletions(-)

-- 
1.8.2.2
