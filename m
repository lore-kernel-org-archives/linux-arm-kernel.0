From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Apr 2017 18:20:43 +0100
Subject: [PATCH v35 02/14] memblock: add memblock_cap_memory_range()
In-Reply-To: <20170403022355.12463-2-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
 <20170403022355.12463-2-takahiro.akashi@linaro.org>
Message-ID: <20170405172043.GA2752@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:23:55AM +0900, AKASHI Takahiro wrote:
> Add memblock_cap_memory_range() which will remove all the memblock regions
> except the memory range specified in the arguments. In addition, rework is
> done on memblock_mem_limit_remove_map() to re-implement it using
> memblock_cap_memory_range().
> 
> This function, like memblock_mem_limit_remove_map(), will not remove
> memblocks with MEMMAP_NOMAP attribute as they may be mapped and accessed
> later as "device memory."
> See the commit a571d4eb55d8 ("mm/memblock.c: add new infrastructure to
> address the mem limit issue").
> 
> This function is used, in a succeeding patch in the series of arm64 kdump
> suuport, to limit the range of usable memory, or System RAM, on crash dump
> kernel.
> (Please note that "mem=" parameter is of little use for this purpose.)
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Dennis Chen <dennis.chen@arm.com>
> Cc: linux-mm at kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 44 +++++++++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 15 deletions(-)

Andrew, are you ok with patches 1 and 2 in this series (touching
mm/memblock.c and include/linux/memblock.h) to go in via the arm64 tree?

Thanks.

-- 
Catalin
