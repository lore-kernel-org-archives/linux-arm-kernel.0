From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 9 Jan 2018 19:33:27 +0000
Subject: [PATCH v2 0/8] arm64: 52-bit physical address support
In-Reply-To: <20171222152307.11252-1-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
Message-ID: <d1f034f7-d079-fbe8-fdb9-388054217941@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:22, Catalin Marinas wrote:
> Hi,
> 
> That's v2 of Kristina's 52-bit PA series, posted here:
> 
> http://lkml.kernel.org/r/1513184845-8711-1-git-send-email-kristina.martsenko at arm.com
> 
> I addressed the comments raised on the list and I plan to push it into
> -next soon.
> 
> Changes in v2:
> 
> - Folded patches 7 and 8 from the original series into 1
> - Definitions for TCR_IPS_*
> - Renamed some asm macros and functions
> - __create_hyp_mappings() changed to avoid passing an extra arg
> - More code comments
> - Added Reviewed/Tested tags I've got so far

Apart from the few things I pointed out, the rest of the changes look
good to me. Thanks.

Kristina

> 
> Thanks,
> 
> Catalin
> 
> Kristina Martsenko (8):
>   arm64: add kconfig symbol to configure physical address size
>   arm64: limit PA size to supported range
>   arm64: handle 52-bit addresses in TTBR
>   arm64: head.S: handle 52-bit PAs in PTEs in early page table setup
>   arm64: don't open code page table entry creation
>   arm64: handle 52-bit physical addresses in page table entries
>   arm64: allow ID map to be extended to 52 bits
>   arm64: enable 52-bit physical address support
> 
>  arch/arm/include/asm/kvm_mmu.h         |   7 ++
>  arch/arm64/Kconfig                     |  29 ++++++++
>  arch/arm64/include/asm/assembler.h     |  36 +++++++++-
>  arch/arm64/include/asm/kvm_mmu.h       |  21 +++++-
>  arch/arm64/include/asm/mmu_context.h   |  20 ++++--
>  arch/arm64/include/asm/pgalloc.h       |   6 +-
>  arch/arm64/include/asm/pgtable-hwdef.h |  25 ++++++-
>  arch/arm64/include/asm/pgtable.h       |  55 ++++++++++++---
>  arch/arm64/include/asm/sparsemem.h     |   2 +-
>  arch/arm64/include/asm/sysreg.h        |   8 +++
>  arch/arm64/kernel/head.S               | 122 +++++++++++++++++++++------------
>  arch/arm64/kernel/hibernate-asm.S      |  12 ++--
>  arch/arm64/kernel/hibernate.c          |   5 +-
>  arch/arm64/kvm/hyp-init.S              |  26 ++++---
>  arch/arm64/kvm/hyp/s2-setup.c          |   2 +
>  arch/arm64/mm/mmu.c                    |  15 ++--
>  arch/arm64/mm/pgd.c                    |   8 +++
>  arch/arm64/mm/proc.S                   |  19 ++---
>  virt/kvm/arm/arm.c                     |   2 +-
>  virt/kvm/arm/mmu.c                     |  10 ++-
>  20 files changed, 323 insertions(+), 107 deletions(-)
> 
