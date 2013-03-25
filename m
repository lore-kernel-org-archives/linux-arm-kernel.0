From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:17:34 +0000
Subject: [PATCH v2 0/5] Fix 740t support and remove more unused ARMv3 code
Message-ID: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a rebased version of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/146095.html

The only changes are that it is now based on 3.9-rc4 and the final patch
has been dropped, having been merged via arm-soc.

I plan to send this via Russell for 3.10.

Cheers,

Will


Will Deacon (5):
  ARM: tlbflush: remove ARMv3 support
  ARM: cache: remove ARMv3 support code
  ARM: mm: fix numerous hideous errors in proc-arm740.S
  ARM: mm: remove broken condition check for v4 flushing
  ARM: modules: don't export cpu_set_pte_ext when !MMU

 arch/arm/include/asm/glue-cache.h |   8 ---
 arch/arm/include/asm/tlbflush.h   |  11 +--
 arch/arm/mm/Kconfig               |   5 +-
 arch/arm/mm/Makefile              |   1 -
 arch/arm/mm/cache-v3.S            | 137 --------------------------------------
 arch/arm/mm/cache-v4.S            |   2 +-
 arch/arm/mm/proc-arm740.S         |  30 +++++----
 arch/arm/mm/proc-syms.c           |   2 +
 8 files changed, 23 insertions(+), 173 deletions(-)
 delete mode 100644 arch/arm/mm/cache-v3.S

-- 
1.8.0
