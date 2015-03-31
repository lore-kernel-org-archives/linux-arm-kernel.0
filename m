From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Mar 2015 16:29:48 +0100
Subject: [PATCH 02/25] arm64: Use bool function return values of
 true/false not 1/0
In-Reply-To: <4e68cc1c7021725e529b0190ff35fa26099b57c5.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
 <4e68cc1c7021725e529b0190ff35fa26099b57c5.1427759009.git.joe@perches.com>
Message-ID: <20150331152947.GC24583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 12:46:00AM +0100, Joe Perches wrote:
> Use the normal return values for bool functions
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm64/include/asm/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 6932bb5..9437e3d 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -97,7 +97,7 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  {
>  	if (!dev->dma_mask)
> -		return 0;
> +		return false;
>  
>  	return addr + size - 1 <= *dev->dma_mask;
>  }
> -- 
> 2.1.2

Looks simple enough, I'll pick it up for 4.1.

Will
