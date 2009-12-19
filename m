From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2009 19:45:41 -0800
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC, kexec, atags
Message-ID: <20091219034151.26198.26570.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some v7 fixes, mostly to make kexec work.

Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
git repo, I can reboot my n900 in a loop reliably.

To clarify, this works booting 2.6.33-rc1 in a loop, booting
the Maemo kernel with kexec does not seem to boot very far
at all for some reason. I'll look into that next.

FYI, if anybody wants to play with it, I used something
like this for kexec:

#!/bin/sh

./kexec -l zImage --command-line="$(cat /proc/cmdline)"
sync
kexec -e

Regards,

Tony


---

Tony Lindgren (5):
      arm: Fix DCC console for v7
      arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work
      arm: Flush TLB entries in setup_mm_for_reboot()
      arm: Fix init_atags_procfs() to check tag->hdr.size
      arm: Fix typo in cacheflush.h and remove unnecessary comments


 arch/arm/boot/compressed/head.S   |    8 ++++++++
 arch/arm/boot/compressed/misc.c   |   12 ++++++++++++
 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/include/asm/setup.h      |   12 +++++++++---
 arch/arm/kernel/atags.c           |    2 +-
 arch/arm/kernel/compat.c          |    2 +-
 arch/arm/kernel/debug.S           |   20 ++++++++++++++++++++
 arch/arm/kernel/setup.c           |    4 ++--
 arch/arm/mach-orion5x/common.c    |    2 +-
 arch/arm/mm/mmu.c                 |    3 +++
 arch/arm/mm/proc-v6.S             |    2 --
 arch/arm/mm/proc-v7.S             |   11 ++++++++---
 12 files changed, 66 insertions(+), 14 deletions(-)

-- 
Signature
