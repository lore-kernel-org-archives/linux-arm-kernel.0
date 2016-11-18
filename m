From: labbott@redhat.com (Laura Abbott)
Date: Thu, 17 Nov 2016 17:16:50 -0800
Subject: [PATCHv3 0/6] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <1479431816-5028-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of the series to add CONFIG_DEBUG_VIRTUAL for arm64.
The biggest change from v2 is the conversion of more __pa sites
to __pa_symbol for stricter checks.

With that expansion, having this go through the arm64 tree is going to be
easiest so I'd like to start getting Acks from x86 and mm maintainers.

Thanks,
Laura

Laura Abbott (6):
  lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
  mm/cma: Cleanup highmem check
  arm64: Move some macros under #ifndef __ASSEMBLY__
  arm64: Add cast for virt_to_pfn
  arm64: Use __pa_symbol for kernel symbols
  arm64: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm64/Kconfig                        |  1 +
 arch/arm64/include/asm/kvm_mmu.h          |  4 +-
 arch/arm64/include/asm/memory.h           | 70 ++++++++++++++++++++++---------
 arch/arm64/include/asm/mmu_context.h      |  6 +--
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/hibernate.c             |  9 ++--
 arch/arm64/kernel/insn.c                  |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/setup.c                 |  8 ++--
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 arch/arm64/kernel/vdso.c                  |  4 +-
 arch/arm64/mm/Makefile                    |  1 +
 arch/arm64/mm/init.c                      | 11 ++---
 arch/arm64/mm/mmu.c                       | 24 +++++------
 arch/arm64/mm/physaddr.c                  | 39 +++++++++++++++++
 arch/x86/Kconfig                          |  1 +
 drivers/firmware/psci.c                   |  2 +-
 lib/Kconfig.debug                         |  5 ++-
 mm/cma.c                                  | 15 +++----
 21 files changed, 140 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

-- 
2.7.4
