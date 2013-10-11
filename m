From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Oct 2013 20:59:15 -0400
Subject: [GIT PULL] ARM: mm: Extend the runtime patch stub for PAE systems
Message-ID: <1381453155-10567-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull below series to extend the existing ARM v2p runtime patching for
64 bit. Needed for LPAE machines which have physical memory beyond 4GB.

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for-rmk/arm-mm-lpae

for you to fetch changes up to a77e0c7b2774fd52ce6bf25c2c3ffdccb7b110ff:

  ARM: mm: Recreate kernel mappings in early_paging_init() (2013-10-10 20:28:19 -0400)

----------------------------------------------------------------
Santosh Shilimkar (4):
      ARM: mm: use phys_addr_t appropriately in p2v and v2p conversions
      ARM: mm: Introduce virt_to_idmap() with an arch hook
      ARM: mm: Move the idmap print to appropriate place in the code
      ARM: mm: Recreate kernel mappings in early_paging_init()

Sricharan R (1):
      ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses

 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/include/asm/memory.h    |   75 +++++++++++++++++++++++++++++-----
 arch/arm/kernel/armksyms.c       |    1 +
 arch/arm/kernel/head.S           |   63 +++++++++++++++++++++--------
 arch/arm/kernel/setup.c          |    4 ++
 arch/arm/kernel/smp.c            |    2 +-
 arch/arm/mm/idmap.c              |    8 ++--
 arch/arm/mm/mmu.c                |   82 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 206 insertions(+), 30 deletions(-)
