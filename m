From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Nov 2016 10:26:21 +0000
Subject: [PATCH v28 1/9] memblock: add memblock_cap_memory_range()
In-Reply-To: <20161124095717.7037-1-takahiro.akashi@linaro.org>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161124095717.7037-1-takahiro.akashi@linaro.org>
Message-ID: <20161124102619.GC78338@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Nov 24, 2016 at 06:57:17PM +0900, AKASHI Takahiro wrote:
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
> Cc: linux-mm at kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 44 +++++++++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 15 deletions(-)

Are you OK with this patch to go in via the arm64 tree (together with
the other patches in this series)?

Thanks.

-- 
Catalin
