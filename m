From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 4 Sep 2017 09:20:39 +0100
Subject: [PATCH] ARM: dma-mapping: Mark atomic_pool as __ro_after_init
In-Reply-To: <1502700619-44809-2-git-send-email-vladimir.murzin@arm.com>
References: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
 <1502700619-44809-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <f9e1e0f6-0d0b-6027-b4d2-eeafb563f2c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 09:50, Vladimir Murzin wrote:
> atomic_pool is setup once while init stage and never changed after
> that, so it is good candidate for __ro_after_init.
> 
> Since we are here mark atomic_pool_size with __init_data.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/dma-mapping.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 25a8bce..ada8eb2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -382,9 +382,9 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
>  }
>  
>  #define DEFAULT_DMA_COHERENT_POOL_SIZE	SZ_256K
> -static struct gen_pool *atomic_pool;
> +static struct gen_pool *atomic_pool __ro_after_init;
>  
> -static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
> +static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
>  
>  static int __init early_coherent_pool(char *p)
>  {
> 

Ok for patch tracker?

Vladimir
