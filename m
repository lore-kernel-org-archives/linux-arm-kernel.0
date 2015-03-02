From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Mar 2015 18:56:07 +0000
Subject: [RFC PATCH 3/4] arm64: add support for memtest
In-Reply-To: <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20150302185607.GG7919@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:55:44PM +0000, Vladimir Murzin wrote:
> Add support for memtest command line option.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/mm/init.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ae85da6..597831b 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -190,6 +190,8 @@ void __init bootmem_init(void)
>  	min = PFN_UP(memblock_start_of_DRAM());
>  	max = PFN_DOWN(memblock_end_of_DRAM());
>  
> +	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
> +
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.

This is really neat, thanks for doing this Vladimir!

  Acked-by: Will Deacon <will.deacon@arm.com>

For the series, modulo Baruch's comments about Documentation updates.

Will
