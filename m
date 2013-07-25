From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 18:01:43 +0100
Subject: [PATCH v3 0/4] Optimise cache-flushing system call
Message-ID: <1374771707-2619-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

This is a refresh of the patches I originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/157810.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170601.html

This is just a rebase onto 3.11-rc2, there are no functional changes to
the series.

Cheers,

Will


Will Deacon (4):
  ARM: entry: allow ARM-private syscalls to be restarted
  ARM: cacheflush: split user cache-flushing into interruptible chunks
  ARM: cacheflush: don't round address range up to nearest page
  ARM: cacheflush: don't bother rounding to nearest vma

 arch/arm/include/asm/cacheflush.h  |  3 +-
 arch/arm/include/asm/thread_info.h | 11 +++++++
 arch/arm/kernel/entry-common.S     |  4 +--
 arch/arm/kernel/traps.c            | 64 +++++++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 19 deletions(-)

-- 
1.8.2.2
