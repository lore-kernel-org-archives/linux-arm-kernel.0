From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 05 Aug 2013 16:31:50 +0200
Subject: [PATCH v4 4/4] ARM: init: add support for reserved memory defined
 by device tree
In-Reply-To: <1375275119-12787-5-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <xa1tr4e8us2x.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31 2013, Marek Szyprowski wrote:
> Enable reserved memory initialization from device tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/arm/mm/init.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 15225d8..82db8d8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -20,6 +20,7 @@
>  #include <linux/highmem.h>
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/sizes.h>
>  
> @@ -377,6 +378,8 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  	if (mdesc->reserve)
>  		mdesc->reserve();
>  
> +	dma_reserved_mem_of_reserve();
> +
>  	/*
>  	 * reserve memory for DMA contigouos allocations,
>  	 * must come from DMA area inside low memory
> -- 
> 1.7.9.5
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/937c3e43/attachment.sig>
