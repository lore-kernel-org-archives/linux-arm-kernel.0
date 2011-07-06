From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 21:31:03 +0100
Subject: [PATCH] ARM: DMA: Silence declared inside parameter list
	warning for !CONFIG_MMU
In-Reply-To: <1309767141.3964.1.camel@phoenix>
References: <1309767141.3964.1.camel@phoenix>
Message-ID: <20110706203103.GT8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 04:12:21PM +0800, Axel Lin wrote:
> Fix below warning, the struct dma_coherent_area takes no space if !CONFIG_MMU.
> 
>   CC      arch/arm/mm/dma-mapping.o
> arch/arm/mm/dma-mapping.c:309: warning: 'struct dma_coherent_area' declared inside parameter list
> arch/arm/mm/dma-mapping.c:309: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mm/dma-mapping.c:334: warning: 'struct dma_coherent_area' declared inside parameter list
> arch/arm/mm/dma-mapping.c:374: warning: 'struct dma_coherent_area' declared inside parameter list
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Ok, can you put this in the patch system please?

Thanks.

> ---
>  arch/arm/mm/dma-mapping.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8089499..da3b33a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -297,6 +297,8 @@ static void dma_free_area(void *cpu_addr, size_t size, struct dma_coherent_area
>  #define coherent_wc_area NULL
>  #define coherent_dma_area NULL
>  
> +struct dma_coherent_area { };
> +
>  void dma_coherent_reserve(void)
>  {
>  }
> -- 
> 1.7.4.1
> 
> 
> 
