From: subashrp@gmail.com (Subash Patel)
Date: Thu, 30 May 2013 19:01:09 +0530
Subject: [PATCH 00/14] Random LPAE-related patches
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <51A7549D.9000103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Sorry for late response, as I was on vacation.

Thanks for these patches. I have tested these patches on exynos5440 
platform. It hasnt affected LPAE functionality for us from previous 
versions(posted by Cyril). You can use "Tested-By: Subash Patel 
<subash.rp@samsung.com>" as you deem necessary.

Regards,
Subash

On 05/17/2013 10:37 PM, Will Deacon wrote:
> Hello,
>
> This is a collection of LPAE-related patches (mostly fixes) that have
> been kicking around for a while and I've been collecting in one place.
> There were some extra patches for bootmem, but they produced lots of
> warnings and need more thought, so they've not been included here.
>
> All comments welcome,
>
> Will
>
> Cyril Chemparathy (9):
>    ARM: LPAE: use signed arithmetic for mask definitions
>    ARM: LPAE: use phys_addr_t in switch_mm()
>    ARM: LPAE: use 64-bit accessors for TTBR registers
>    ARM: LPAE: factor out T1SZ and TTBR1 computations
>    ARM: LPAE: accomodate >32-bit addresses for page table base
>    ARM: mm: use physical addresses in highmem sanity checks
>    ARM: fix type of PHYS_PFN_OFFSET to unsigned long
>    ARM: mm: cleanup checks for membank overlap with vmalloc area
>    ARM: mm: clean up membank size limit checks
>
> Vitaly Andrianov (3):
>    ARM: LPAE: use phys_addr_t in alloc_init_pud()
>    ARM: LPAE: use phys_addr_t in free_memmap()
>    ARM: LPAE: use phys_addr_t for initrd location
>
> Will Deacon (2):
>    ARM: lpae: fix definition of PTE_HWTABLE_PTRS
>    ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions
>
>   arch/arm/include/asm/memory.h               | 18 +++++++++-
>   arch/arm/include/asm/page.h                 |  2 +-
>   arch/arm/include/asm/pgtable-3level-hwdef.h | 20 +++++++++++
>   arch/arm/include/asm/pgtable-3level.h       |  8 ++---
>   arch/arm/include/asm/proc-fns.h             | 26 ++++++++++----
>   arch/arm/include/uapi/asm/hwcap.h           |  2 +-
>   arch/arm/kernel/head.S                      | 10 +++---
>   arch/arm/kernel/setup.c                     |  8 ++++-
>   arch/arm/kernel/smp.c                       | 11 ++++--
>   arch/arm/mm/context.c                       |  9 ++---
>   arch/arm/mm/init.c                          | 19 ++++++-----
>   arch/arm/mm/mmu.c                           | 49 +++++++++-----------------
>   arch/arm/mm/proc-v7-3level.S                | 53 +++++++++++++++--------------
>   13 files changed, 139 insertions(+), 96 deletions(-)
>
