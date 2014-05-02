From: robherring2@gmail.com (Rob Herring)
Date: Thu, 1 May 2014 19:58:22 -0500
Subject: [PATCH v3 6/7] ARM: dma: implement set_arch_dma_coherent_ops()
In-Reply-To: <1398353407-2345-7-git-send-email-santosh.shilimkar@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <1398353407-2345-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAL_JsqLwerrkCeNsADy0Z=HWwEOWw9eUS+tOfbEgdaCce5GtbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:30 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Implement the set_arch_dma_coherent_ops() for ARM architecture.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Rob Herring <robh@kernel.org>

> ---
>  arch/arm/include/asm/dma-mapping.h |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 424fda9..1965cd8 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -118,6 +118,13 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  }
>  #define dma_max_pfn(dev) dma_max_pfn(dev)
>
> +static inline int set_arch_dma_coherent_ops(struct device *dev)
> +{
> +       set_dma_ops(dev, &arm_coherent_dma_ops);
> +       return 0;
> +}
> +#define set_arch_dma_coherent_ops(dev) set_arch_dma_coherent_ops(dev)
> +
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>         unsigned int offset = paddr & ~PAGE_MASK;
> --
> 1.7.9.5
>
