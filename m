From: john.stultz@linaro.org (John Stultz)
Date: Mon, 13 Dec 2010 20:57:35 -0800
Subject: [PATCH 0/4][RFC] Trivial ARM related Android patches
Message-ID: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So after all the heat that was generated in the various Android
discussions, I took a look a look at the android git tree, and 
while there are a fair number of large and controversial 
infrastructure changes, there are also a number of small fixes 
that apply easily against Linus' git tree.

So after cherry picking these 50-some small patches out of the
android tree, I organized them into topic branches, and over
the next few weeks, I hope to send them out to lkml and topic
maintainers for comments.

Now, I'm not proposing that these changes be merged as-is. It
may very well be that, unknown to me, android developers have
already tried to submit these patches and they have been rejected
for good reason. Or some patches may very well be necessary hacks
to get thing shipping while deeper fixes are being worked on. If
that is the case, let me know and forgive me for the noise.

But as, it seemed many of these small changes have been obscured
by the debate over the larger infrastructure changes, I wanted 
to bring them forward so that possibly good fixes were not missed
in the controversy.

Maintainers: If you do find any of these patches distasteful,
that's fine, I'll be happy to drop them from my tree for now.
I really don't want to stir up another huge mail thread over these 
small patches, but I'd appreciate if you'd consider them as a
bug report illustrating an issue or a desired feature, and suggest 
what you see as a reasonable way to accomplish the desired
functionality presented in the patch.

The following patches are just the ARM related trivial patches
from the Android tree. You can find these as well as my other
Android topic branches here:
http://git.linaro.org/gitweb?p=people/jstultz/linux.git;a=summary

thanks
-john

CC: Arve Hj?nnev?g <arve@android.com>
CC: Brian Swetland <swetland@google.com>
CC: Dima Zavin <dima@android.com>
CC: San Mehat <san@google.com>
CC: Michael Davidson <md@google.com>
CC: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>


Arve Hj??nnev??g (1):
  Optionally flush entire dcache from v6_dma_flush_range

Brian Swetland (1):
  avoid mis-detecting some V7 cores in the decompressor

Dima Zavin (1):
  Do not call flush_cache_user_range with mmap_sem held

San Mehat (1):
  process: Add display of memory around registers when displaying regs.

 arch/arm/boot/compressed/head.S   |    3 ++
 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/kernel/process.c         |   73 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c           |    4 ++-
 arch/arm/mm/cache-v6.S            |   17 +++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

-- 
1.7.3.2.146.gca209
