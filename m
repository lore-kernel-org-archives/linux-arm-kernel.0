From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Aug 2013 23:49:12 +0100
Subject: [PATCH v7 4/4] ARM: init: add support for reserved memory defined
 by device tree
In-Reply-To: <1377527959-5080-5-git-send-email-m.szyprowski@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20130829224912.7B2933E1222@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Aug 2013 16:39:19 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Enable reserved memory initialization from device tree.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mm/init.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 15225d8..6a2fe44 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -17,6 +17,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/highmem.h>
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
> @@ -377,6 +378,8 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  	if (mdesc->reserve)
>  		mdesc->reserve();
>  
> +	early_init_dt_scan_reserved_mem();
> +

Don't forget ARM64.

g.
