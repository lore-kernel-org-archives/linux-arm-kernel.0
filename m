From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Dec 2011 15:29:55 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
Message-ID: <20111206152955.GC31720@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I updated the series with an additional signed-off-by to your patch. The
code is unchanged. Could you please pull it again?

Thanks.

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux.git for-next

Catalin Marinas (12):
      ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud
      ARM: LPAE: Move page table maintenance macros to pgtable-2level.h
      ARM: LPAE: Move the FSR definitions to separate files
      ARM: LPAE: Factor out classic-MMU specific code into proc-v7-2level.S
      ARM: LPAE: Introduce the 3-level page table format definitions
      ARM: LPAE: Page table maintenance for the 3-level format
      ARM: LPAE: MMU setup for the 3-level page table format
      ARM: LPAE: Invalidate the TLB before freeing the PMD
      ARM: LPAE: Add fault handling support
      ARM: LPAE: Add context switching support
      ARM: LPAE: Add identity mapping support for the 3-level page table format
      ARM: LPAE: Add the Kconfig entries

Russell King (1):
      ARM: pgtable: switch to use pgtable-nopud.h

Will Deacon (2):
      ARM: LPAE: add ISBs around MMU enabling code
      ARM: LPAE: mark memory banks with start > ULONG_MAX as highmem

 arch/arm/Kconfig                            |    2 +-
 arch/arm/boot/compressed/head.S             |    1 +
 arch/arm/include/asm/assembler.h            |   11 ++
 arch/arm/include/asm/page.h                 |    4 +
 arch/arm/include/asm/pgalloc.h              |   26 ++++-
 arch/arm/include/asm/pgtable-2level.h       |   41 ++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |   77 ++++++++++++
 arch/arm/include/asm/pgtable-3level-types.h |   70 +++++++++++
 arch/arm/include/asm/pgtable-3level.h       |  155 +++++++++++++++++++++++
 arch/arm/include/asm/pgtable-hwdef.h        |    4 +
 arch/arm/include/asm/pgtable.h              |   43 +------
 arch/arm/include/asm/proc-fns.h             |   21 +++
 arch/arm/include/asm/system.h               |    8 ++
 arch/arm/include/asm/tlb.h                  |   12 ++-
 arch/arm/kernel/head.S                      |   47 +++++++-
 arch/arm/kernel/hw_breakpoint.c             |    8 +-
 arch/arm/kernel/sleep.S                     |    2 +
 arch/arm/mm/Kconfig                         |   17 +++
 arch/arm/mm/alignment.c                     |    2 +-
 arch/arm/mm/context.c                       |   19 +++-
 arch/arm/mm/fault.c                         |  111 +++--------------
 arch/arm/mm/fault.h                         |   27 ++++-
 arch/arm/mm/fsr-2level.c                    |   78 ++++++++++++
 arch/arm/mm/fsr-3level.c                    |   68 ++++++++++
 arch/arm/mm/idmap.c                         |   34 +++++-
 arch/arm/mm/ioremap.c                       |   39 ++++---
 arch/arm/mm/mmu.c                           |   46 +++++++-
 arch/arm/mm/pgd.c                           |   51 +++++++-
 arch/arm/mm/proc-macros.S                   |    5 +-
 arch/arm/mm/proc-v7-2level.S                |  171 ++++++++++++++++++++++++++
 arch/arm/mm/proc-v7-3level.S                |  150 +++++++++++++++++++++++
 arch/arm/mm/proc-v7.S                       |  177 +++------------------------
 32 files changed, 1204 insertions(+), 323 deletions(-)
 create mode 100644 arch/arm/include/asm/pgtable-3level-hwdef.h
 create mode 100644 arch/arm/include/asm/pgtable-3level-types.h
 create mode 100644 arch/arm/include/asm/pgtable-3level.h
 create mode 100644 arch/arm/mm/fsr-2level.c
 create mode 100644 arch/arm/mm/fsr-3level.c
 create mode 100644 arch/arm/mm/proc-v7-2level.S
 create mode 100644 arch/arm/mm/proc-v7-3level.S
