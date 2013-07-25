From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 16:55:34 +0100
Subject: [PATCH v2 0/6] Add support for pldw instruction on v7 MP cores
Message-ID: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Thie is version two of that patches I posted the other day:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185663.html

Changes since v1 include:

	- Rewrite prefetch and prefetchw as macros, to avoid explicit
	  casting in the caller (also requires changing the type of
	  arch_rwlock_t to remove the volatile member).

	- Some cosmetic cleanups.

Thanks to Nicolas for the feedback received so far.

Will


Will Deacon (6):
  ARM: prefetch: remove redundant "cc" clobber
  ARM: smp_on_up: move inline asm ALT_SMP patching macro out of
    spinlock.h
  ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
  ARM: locks: prefetch the destination word for write prior to strex
  ARM: atomics: prefetch the destination word for write prior to strex
  ARM: bitops: prefetch the destination word for write prior to strex

 arch/arm/include/asm/atomic.h         |  7 ++++++
 arch/arm/include/asm/processor.h      | 43 ++++++++++++++++++++++++-----------
 arch/arm/include/asm/spinlock.h       | 28 +++++++++++------------
 arch/arm/include/asm/spinlock_types.h |  2 +-
 arch/arm/include/asm/unified.h        |  4 ++++
 arch/arm/lib/bitops.h                 |  5 ++++
 6 files changed, 61 insertions(+), 28 deletions(-)

-- 
1.8.2.2
