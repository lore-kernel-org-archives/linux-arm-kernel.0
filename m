From: Pavel.Tatashin@microsoft.com (Pasha Tatashin)
Date: Fri, 17 Aug 2018 01:08:50 +0000
Subject: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <1530867675-9018-4-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
Message-ID: <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ccad225..84f7fa7 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> +static int early_region_idx __init_memblock = -1;

One comment:

This should be __initdata, but even better bring it inside the function
as local static variable.

>  ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
>  {

Otherwise looks good:

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
