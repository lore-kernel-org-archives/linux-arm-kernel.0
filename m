From: mina86@mina86.com (Michal Nazarewicz)
Date: Sun, 24 Aug 2014 15:34:36 +0200
Subject: [PATCH 2/2] ARM: mm: don't limit default CMA region only to low
 memory
In-Reply-To: <1408610714-16204-3-git-send-email-m.szyprowski@samsung.com>
References: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
 <1408610714-16204-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <xa1tvbpiui37.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21 2014, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> DMA-mapping supports CMA regions places either in low or high memory, so
> there is no longer needed to limit default CMA regions only to low memory.
> The real limit is still defined by architecture specific DMA limit.
>
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/arm/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 659c75d808dc..c1b513555786 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -322,7 +322,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>  	 * reserve memory for DMA contigouos allocations,
>  	 * must come from DMA area inside low memory
>  	 */
> -	dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
> +	dma_contiguous_reserve(arm_dma_limit);
>  
>  	arm_memblock_steal_permitted = false;
>  	memblock_dump_all();
> -- 
> 1.9.2
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
