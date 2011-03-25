From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 25 Mar 2011 09:02:26 +0100
Subject: arm: Move the definition of ARCH_HAS_DMA_MMAP_COHERENT where it
	belongs
In-Reply-To: <1301035670.2402.468.camel@pasglop>
References: <1301035670.2402.468.camel@pasglop>
Message-ID: <s5h7hbnvd9p.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Fri, 25 Mar 2011 17:47:50 +1100,
Benjamin Herrenschmidt wrote:
> 
> Something I noticed while implementing dma_mmap_coherent() for powerpc...
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for catching up!

Acked-by: Takashi Iwai <tiwai@suse.de>


Takashi

> ---
>  arch/arm/include/asm/dma-mapping.h |    2 +-
>  sound/core/pcm_native.c            |    7 -------
>  2 files changed, 1 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 4fff837..ed33eab 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -214,7 +214,7 @@ extern void dma_free_coherent(struct device *, size_t, void *, dma_addr_t);
>   */
>  int dma_mmap_coherent(struct device *, struct vm_area_struct *,
>  		void *, dma_addr_t, size_t);
> -
> +#define ARCH_HAS_DMA_MMAP_COHERENT
>  
>  /**
>   * dma_alloc_writecombine - allocate writecombining memory for DMA
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index ae42b65..2d99c37 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3145,13 +3145,6 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
>  	.fault =	snd_pcm_mmap_data_fault,
>  };
>  
> -#ifndef ARCH_HAS_DMA_MMAP_COHERENT
> -/* This should be defined / handled globally! */
> -#ifdef CONFIG_ARM
> -#define ARCH_HAS_DMA_MMAP_COHERENT
> -#endif
> -#endif
> -
>  /*
>   * mmap the DMA buffer on RAM
>   */
> 
> 
> 
