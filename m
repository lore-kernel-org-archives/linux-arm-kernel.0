From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Mar 2013 10:49:15 +0000
Subject: [GIT PULL] Fix 740t support for 3.10
Message-ID: <20130328104915.GA446@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This is the patch series fixing 740t support and removing some more
unused ARMv3 code. Please pull for 3.10.

Cheers,

Will

--->8

The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/740t

for you to fetch changes up to d455bac223d6f9858b29a29272756243ec3d3904:

  ARM: modules: don't export cpu_set_pte_ext when !MMU (2013-03-26 09:55:34 +0000)

----------------------------------------------------------------
Will Deacon (5):
      ARM: tlbflush: remove ARMv3 support
      ARM: cache: remove ARMv3 support code
      ARM: mm: fix numerous hideous errors in proc-arm740.S
      ARM: mm: remove broken condition check for v4 flushing
      ARM: modules: don't export cpu_set_pte_ext when !MMU

 arch/arm/include/asm/glue-cache.h |   8 --------
 arch/arm/include/asm/tlbflush.h   |  11 ++---------
 arch/arm/mm/Kconfig               |   5 +----
 arch/arm/mm/Makefile              |   1 -
 arch/arm/mm/cache-v3.S            | 137 -----------------------------------------------------------------------------------------------------------------------------------------
 arch/arm/mm/cache-v4.S            |   2 +-
 arch/arm/mm/proc-arm740.S         |  30 +++++++++++++++++-------------
 arch/arm/mm/proc-syms.c           |   2 ++
 8 files changed, 23 insertions(+), 173 deletions(-)
 delete mode 100644 arch/arm/mm/cache-v3.S
