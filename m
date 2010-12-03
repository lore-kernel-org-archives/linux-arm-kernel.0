From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 17:22:33 +0000
Subject: [PATCH 14/54] ARM: ebsa110: irq_data conversion.
In-Reply-To: <20101130133638.GO15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133638.GO15575@mail.wantstofly.org>
Message-ID: <20101203172233.GE30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:36:38PM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mach-ebsa110/core.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
> index 5df4099..7df083f 100644
> --- a/arch/arm/mach-ebsa110/core.c
> +++ b/arch/arm/mach-ebsa110/core.c
> @@ -35,20 +35,20 @@
>  #define IRQ_STAT		0xff000000	/* read */
>  #define IRQ_MCLR		0xff000000	/* write */
>  
> -static void ebsa110_mask_irq(unsigned int irq)
> +static void ebsa110_mask_irq(struct irq_data *d)
>  {
> -	__raw_writeb(1 << irq, IRQ_MCLR);
> +	__raw_writeb(1 << d->irq, IRQ_MCLR);
>  }
>  
> -static void ebsa110_unmask_irq(unsigned int irq)
> +static void ebsa110_unmask_irq(struct irq_data *d)
>  {
> -	__raw_writeb(1 << irq, IRQ_MSET);
> +	__raw_writeb(1 << d->irq, IRQ_MSET);
>  }
>  
>  static struct irq_chip ebsa110_irq_chip = {
> -	.ack	= ebsa110_mask_irq,
> -	.mask	= ebsa110_mask_irq,
> -	.unmask = ebsa110_unmask_irq,
> +	.irq_ack	= ebsa110_mask_irq,
> +	.irq_mask	= ebsa110_mask_irq,
> +	.irq_unmask	= ebsa110_unmask_irq,
>  };
>   
>  static void __init ebsa110_init_irq(void)
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
