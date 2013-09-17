From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Sep 2013 14:29:32 +0100
Subject: [PATCH v3 0/6] Add support for pldw instruction on v7 MP cores
Message-ID: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version three of the patches I have previously posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185663.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186411.html

This version is simply a rebase on top of v3.12-rc1, since I concentrated
on getting my memory barrier improvements into 3.12 ahead of this series.
I'm aiming to get this merged for 3.13.

All feedback welcome,

Will


Will Deacon (6):
  ARM: prefetch: remove redundant "cc" clobber
  ARM: smp_on_up: move inline asm ALT_SMP patching macro out of
    spinlock.h
  ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
  ARM: locks: prefetch the destination word for write prior to strex
  ARM: atomics: prefetch the destination word for write prior to strex
  ARM: bitops: prefetch the destination word for write prior to strex

 arch/arm/include/asm/atomic.h         |  7 +++++++
 arch/arm/include/asm/processor.h      | 33 +++++++++++++++++++++++++--------
 arch/arm/include/asm/spinlock.h       | 28 ++++++++++++++--------------
 arch/arm/include/asm/spinlock_types.h |  2 +-
 arch/arm/include/asm/unified.h        |  4 ++++
 arch/arm/lib/bitops.h                 |  5 +++++
 6 files changed, 56 insertions(+), 23 deletions(-)

-- 
1.8.2.2
