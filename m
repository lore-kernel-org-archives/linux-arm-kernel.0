From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Oct 2012 15:48:52 +0100
Subject: [PATCH RFT] ARM64: dma-mapping: support debug_dma_mapping_error
In-Reply-To: <1351205220.6851.3.camel@lorien2>
References: <1351205220.6851.3.camel@lorien2>
Message-ID: <CAHkRjk6jDKsFMa1_Wapwr7y5n8Ut8xfNBKWniSfHN_01z7qWFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 October 2012 23:47, Shuah Khan <shuah.khan@hp.com> wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
>
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
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
>         struct dma_map_ops *ops = get_dma_ops(dev);
> +       debug_dma_mapping_error(dev, dev_addr);
>         return ops->mapping_error(dev, dev_addr);
>  }

The patch looks fine but debug_dma_mapping_error() is not in mainline
yet, so it will have to wait. If you want to add it to your series
(which I assume adds debug_dma_mapping_error() support), you can add
my Acked-by on the patch.

-- 
Catalin
