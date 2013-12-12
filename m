From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:45 +0000
Subject: [PATCH 0/5] a few small fixups for arm64
Message-ID: <cover.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Here are a few small fixups for arm64 that I need for my kexec work.

For PATCH #2 (arm64: Fix the soft_restart routine) I put the jump to
the identity mapped physical address in the caller of cpu_reset, soft_restart.
Another way is to put the jump into cpu_reset.  cpu_reset could also have a
conditional to check if running from a virtual address.  Let me know what you
prefer. 

-Geoff

The following changes since commit db4ed53cfe9f5a00355891a631d47dfa3fd4541f:

  arm64: mm: Fix PMD_SECT_PROT_NONE definition (2013-12-06 17:22:44 +0000)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-arm64

for you to fetch changes up to 92660d1b81279aa6784a33eff2f102e78d883931:

  arm64: Add LOAD_OFFSET symbol for linker scripts (2013-12-12 12:13:04 -0800)

----------------------------------------------------------------
Geoff Levand (5):
      arm64: Fix __data_loc value
      arm64: Fix the soft_restart routine
      arm64: Fix include header order in vmlinux.lds.S
      arm64: Add missing AT() macros to vmlinux.lds.S
      arm64: Add LOAD_OFFSET symbol for linker scripts

 arch/arm64/include/asm/memory.h |  2 ++
 arch/arm64/kernel/process.c     |  8 +++++++-
 arch/arm64/kernel/vmlinux.lds.S | 14 +++++++-------
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
1.8.1.2
