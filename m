From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 13:35:39 -0800
Subject: [PATCHv7 00/11] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <1484084150-1523-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v7 of the patches to add CONFIG_DEBUG_VIRTUAL for arm64. This is
a simple reordering of patches from v6 per request of Will Deacon for ease
of merging support for arm which depends on this series.

Laura Abbott (11):
  lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
  mm/cma: Cleanup highmem check
  mm: Introduce lm_alias
  kexec: Switch to __pa_symbol
  mm/kasan: Switch to using __pa_symbol and lm_alias
  mm/usercopy: Switch to using lm_alias
  drivers: firmware: psci: Use __pa_symbol for kernel symbol
  arm64: Move some macros under #ifndef __ASSEMBLY__
  arm64: Add cast for virt_to_pfn
  arm64: Use __pa_symbol for kernel symbols
  arm64: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm64/Kconfig                        |  1 +
 arch/arm64/include/asm/kvm_mmu.h          |  4 +-
 arch/arm64/include/asm/memory.h           | 66 +++++++++++++++++++++----------
 arch/arm64/include/asm/mmu_context.h      |  6 +--
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  3 +-
 arch/arm64/kernel/cpu-reset.h             |  2 +-
 arch/arm64/kernel/cpufeature.c            |  3 +-
 arch/arm64/kernel/hibernate.c             | 20 +++-------
 arch/arm64/kernel/insn.c                  |  2 +-
 arch/arm64/kernel/psci.c                  |  3 +-
 arch/arm64/kernel/setup.c                 |  9 +++--
 arch/arm64/kernel/smp_spin_table.c        |  3 +-
 arch/arm64/kernel/vdso.c                  |  8 +++-
 arch/arm64/mm/Makefile                    |  2 +
 arch/arm64/mm/init.c                      | 12 +++---
 arch/arm64/mm/kasan_init.c                | 22 +++++++----
 arch/arm64/mm/mmu.c                       | 33 ++++++++++------
 arch/arm64/mm/physaddr.c                  | 30 ++++++++++++++
 arch/x86/Kconfig                          |  1 +
 drivers/firmware/psci.c                   |  2 +-
 include/linux/mm.h                        |  4 ++
 kernel/kexec_core.c                       |  2 +-
 lib/Kconfig.debug                         |  5 ++-
 mm/cma.c                                  | 15 +++----
 mm/kasan/kasan_init.c                     | 15 +++----
 mm/usercopy.c                             |  4 +-
 27 files changed, 180 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

-- 
2.7.4
