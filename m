From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Jun 2018 17:06:20 +0100
Subject: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,
 lock}.h and use on arm64
Message-ID: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series has previously been posted in RFC form here:

  RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
  RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
     v1: https://www.spinics.net/lists/arm-kernel/msg655262.html

The only change since v1 is that some of the fetch ops are replaced
by non-value-returning ops for some of the atomic bitops.

Thanks,

Will

--->8

Will Deacon (9):
  h8300: Don't include linux/kernel.h in asm/atomic.h
  m68k: Don't use asm-generic/bitops/lock.h
  asm-generic: Move some macros from linux/bitops.h to a new bits.h file
  openrisc: Don't pull in all of linux/bitops.h in asm/cmpxchg.h
  sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
  asm-generic/bitops/atomic.h: Rewrite using atomic_*
  asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*
  arm64: Replace our atomic/lock bitop implementations with asm-generic
  arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>

 arch/arm64/include/asm/bitops.h     |  21 +---
 arch/arm64/lib/Makefile             |   2 +-
 arch/arm64/lib/bitops.S             |  76 ---------------
 arch/h8300/include/asm/atomic.h     |   4 +-
 arch/m68k/include/asm/bitops.h      |   6 +-
 arch/openrisc/include/asm/cmpxchg.h |   3 +-
 arch/sh/include/asm/cmpxchg-xchg.h  |   3 +-
 include/asm-generic/bitops/atomic.h | 188 +++++++-----------------------------
 include/asm-generic/bitops/lock.h   |  68 ++++++++++---
 include/linux/bitops.h              |  22 +----
 include/linux/bits.h                |  26 +++++
 11 files changed, 131 insertions(+), 288 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S
 create mode 100644 include/linux/bits.h

-- 
2.1.4
