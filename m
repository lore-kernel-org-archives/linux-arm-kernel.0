From: shuah.khan@hp.com (Shuah Khan)
Date: Fri, 02 Nov 2012 09:58:53 -0600
Subject: [PATCH linux-next] ARM64: dma-mapping: support
 debug_dma_mapping_error
In-Reply-To: <1351264983.2712.14.camel@lorien2>
References: <1351205220.6851.3.camel@lorien2>
 <CAHkRjk6jDKsFMa1_Wapwr7y5n8Ut8xfNBKWniSfHN_01z7qWFQ@mail.gmail.com>
 <1351264983.2712.14.camel@lorien2>
Message-ID: <1351871933.2721.10.camel@lorien2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-26 at 09:23 -0600, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated. 
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Do you want this patch going through linux-next or the ARM64 tree? Let
me know your preference.

-- Shuah
> ---
>  arch/arm64/include/asm/dma-mapping.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 538f4b4..9947768 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -50,6 +50,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>  static inline int dma_mapping_error(struct device *dev, dma_addr_t dev_addr)
>  {
>  	struct dma_map_ops *ops = get_dma_ops(dev);
> +	debug_dma_mapping_error(dev, dev_addr);
>  	return ops->mapping_error(dev, dev_addr);
>  }
>  
