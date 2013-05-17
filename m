From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 May 2013 23:53:56 +0530
Subject: [PATCH 00/14] Random LPAE-related patches
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <519675BC.8010800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 May 2013 10:37 PM, Will Deacon wrote:
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
>   ARM: LPAE: use signed arithmetic for mask definitions
>   ARM: LPAE: use phys_addr_t in switch_mm()
>   ARM: LPAE: use 64-bit accessors for TTBR registers
>   ARM: LPAE: factor out T1SZ and TTBR1 computations
>   ARM: LPAE: accomodate >32-bit addresses for page table base
>   ARM: mm: use physical addresses in highmem sanity checks
>   ARM: fix type of PHYS_PFN_OFFSET to unsigned long
>   ARM: mm: cleanup checks for membank overlap with vmalloc area
>   ARM: mm: clean up membank size limit checks
> 
> Vitaly Andrianov (3):
>   ARM: LPAE: use phys_addr_t in alloc_init_pud()
>   ARM: LPAE: use phys_addr_t in free_memmap()
>   ARM: LPAE: use phys_addr_t for initrd location
> 
> Will Deacon (2):
>   ARM: lpae: fix definition of PTE_HWTABLE_PTRS
>   ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions
> 
Thanks for picking up the patches. As off-list discussed, I have
tested these patches along with remainder bootmem related patches.

Feel free to use,
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
