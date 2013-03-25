From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:18:03 +0000
Subject: [PATCH 0/3] Optimise cache-flushing system call and add iovec variant
Message-ID: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series has been sitting on my box for some time, pending
benchmark results and analysis.

The results are that, with the first two patches in this series, we see
~2% improvement in browser benchmark scores, which flush the cache fairly
regularly in response to jitting JS code.

The final patch is more of an RFC, since I don't have any software that
uses it outside of my toy programs.

All feedback welcome,

Will


Will Deacon (3):
  ARM: cacheflush: don't round address range up to nearest page
  ARM: cacheflush: don't bother rounding to nearest vma
  ARM: cacheflush: add new iovec-based cache flushing system call

 arch/arm/include/asm/cacheflush.h  |  3 +--
 arch/arm/include/uapi/asm/unistd.h |  1 +
 arch/arm/kernel/traps.c            | 49 +++++++++++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 16 deletions(-)

-- 
1.8.0
