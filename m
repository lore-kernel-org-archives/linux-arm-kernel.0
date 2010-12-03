From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 17:26:42 +0000
Subject: [PATCH 47/54] ARM: versatile: irq_data conversion.
In-Reply-To: <20101130134119.GV15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134119.GV15575@mail.wantstofly.org>
Message-ID: <20101203172642.GJ30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:41:19PM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mach-versatile/core.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index e38acb0..9b9b6fa 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -62,23 +62,23 @@
>  #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
>  #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
>  
> -static void sic_mask_irq(unsigned int irq)
> +static void sic_mask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;
>  	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
>  }
>  
> -static void sic_unmask_irq(unsigned int irq)
> +static void sic_unmask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;
>  	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_SET);
>  }
>  
>  static struct irq_chip sic_chip = {
> -	.name	= "SIC",
> -	.ack	= sic_mask_irq,
> -	.mask	= sic_mask_irq,
> -	.unmask	= sic_unmask_irq,
> +	.name		= "SIC",
> +	.irq_ack	= sic_mask_irq,
> +	.irq_mask	= sic_mask_irq,
> +	.irq_unmask	= sic_unmask_irq,
>  };
>  
>  static void
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
