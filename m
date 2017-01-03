From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 3 Jan 2017 14:56:49 -0800
Subject: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <1483464113-1587-1-git-send-email-labbott@redhat.com>
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
Message-ID: <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 09:21 AM, Laura Abbott wrote:
> Happy New Year!
> 
> This is a very minor rebase from v5. It only moves a few headers around.
> I think this series should be ready to be queued up for 4.11.

FWIW:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

How do we get this series included? I would like to get the ARM 32-bit
counterpart included as well (will resubmit rebased shortly), but I have
no clue which tree this should be going through.

Thanks!

> 
> Thanks,
> Laura
> 
> Laura Abbott (11):
>   lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
>   mm/cma: Cleanup highmem check
>   arm64: Move some macros under #ifndef __ASSEMBLY__
>   arm64: Add cast for virt_to_pfn
>   mm: Introduce lm_alias
>   arm64: Use __pa_symbol for kernel symbols
>   drivers: firmware: psci: Use __pa_symbol for kernel symbol
>   kexec: Switch to __pa_symbol
>   mm/kasan: Switch to using __pa_symbol and lm_alias
>   mm/usercopy: Switch to using lm_alias
>   arm64: Add support for CONFIG_DEBUG_VIRTUAL
> 
>  arch/arm64/Kconfig                        |  1 +
>  arch/arm64/include/asm/kvm_mmu.h          |  4 +-
>  arch/arm64/include/asm/memory.h           | 66 +++++++++++++++++++++----------
>  arch/arm64/include/asm/mmu_context.h      |  6 +--
>  arch/arm64/include/asm/pgtable.h          |  2 +-
>  arch/arm64/kernel/acpi_parking_protocol.c |  3 +-
>  arch/arm64/kernel/cpu-reset.h             |  2 +-
>  arch/arm64/kernel/cpufeature.c            |  3 +-
>  arch/arm64/kernel/hibernate.c             | 20 +++-------
>  arch/arm64/kernel/insn.c                  |  2 +-
>  arch/arm64/kernel/psci.c                  |  3 +-
>  arch/arm64/kernel/setup.c                 |  9 +++--
>  arch/arm64/kernel/smp_spin_table.c        |  3 +-
>  arch/arm64/kernel/vdso.c                  |  8 +++-
>  arch/arm64/mm/Makefile                    |  2 +
>  arch/arm64/mm/init.c                      | 12 +++---
>  arch/arm64/mm/kasan_init.c                | 22 +++++++----
>  arch/arm64/mm/mmu.c                       | 33 ++++++++++------
>  arch/arm64/mm/physaddr.c                  | 30 ++++++++++++++
>  arch/x86/Kconfig                          |  1 +
>  drivers/firmware/psci.c                   |  2 +-
>  include/linux/mm.h                        |  4 ++
>  kernel/kexec_core.c                       |  2 +-
>  lib/Kconfig.debug                         |  5 ++-
>  mm/cma.c                                  | 15 +++----
>  mm/kasan/kasan_init.c                     | 15 +++----
>  mm/usercopy.c                             |  4 +-
>  27 files changed, 180 insertions(+), 99 deletions(-)
>  create mode 100644 arch/arm64/mm/physaddr.c
> 


-- 
Florian
