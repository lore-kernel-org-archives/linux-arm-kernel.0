From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 17:26:12 +0000
Subject: [PATCH 39/54] ARM: rpc: irq_data conversion.
In-Reply-To: <20101130134111.GN15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134111.GN15575@mail.wantstofly.org>
Message-ID: <20101203172612.GI30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:41:11PM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mach-rpc/irq.c |   60 +++++++++++++++++++++++-----------------------
>  1 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
> index 9dd15d6..d29cd9b 100644
> --- a/arch/arm/mach-rpc/irq.c
> +++ b/arch/arm/mach-rpc/irq.c
> @@ -6,110 +6,110 @@
>  #include <asm/hardware/iomd.h>
>  #include <asm/irq.h>
>  
> -static void iomd_ack_irq_a(unsigned int irq)
> +static void iomd_ack_irq_a(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << irq;
> +	mask = 1 << d->irq;
>  	val = iomd_readb(IOMD_IRQMASKA);
>  	iomd_writeb(val & ~mask, IOMD_IRQMASKA);
>  	iomd_writeb(mask, IOMD_IRQCLRA);
>  }
>  
> -static void iomd_mask_irq_a(unsigned int irq)
> +static void iomd_mask_irq_a(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << irq;
> +	mask = 1 << d->irq;
>  	val = iomd_readb(IOMD_IRQMASKA);
>  	iomd_writeb(val & ~mask, IOMD_IRQMASKA);
>  }
>  
> -static void iomd_unmask_irq_a(unsigned int irq)
> +static void iomd_unmask_irq_a(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << irq;
> +	mask = 1 << d->irq;
>  	val = iomd_readb(IOMD_IRQMASKA);
>  	iomd_writeb(val | mask, IOMD_IRQMASKA);
>  }
>  
>  static struct irq_chip iomd_a_chip = {
> -	.ack	= iomd_ack_irq_a,
> -	.mask	= iomd_mask_irq_a,
> -	.unmask = iomd_unmask_irq_a,
> +	.irq_ack	= iomd_ack_irq_a,
> +	.irq_mask	= iomd_mask_irq_a,
> +	.irq_unmask	= iomd_unmask_irq_a,
>  };
>  
> -static void iomd_mask_irq_b(unsigned int irq)
> +static void iomd_mask_irq_b(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_IRQMASKB);
>  	iomd_writeb(val & ~mask, IOMD_IRQMASKB);
>  }
>  
> -static void iomd_unmask_irq_b(unsigned int irq)
> +static void iomd_unmask_irq_b(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_IRQMASKB);
>  	iomd_writeb(val | mask, IOMD_IRQMASKB);
>  }
>  
>  static struct irq_chip iomd_b_chip = {
> -	.ack	= iomd_mask_irq_b,
> -	.mask	= iomd_mask_irq_b,
> -	.unmask = iomd_unmask_irq_b,
> +	.irq_ack	= iomd_mask_irq_b,
> +	.irq_mask	= iomd_mask_irq_b,
> +	.irq_unmask	= iomd_unmask_irq_b,
>  };
>  
> -static void iomd_mask_irq_dma(unsigned int irq)
> +static void iomd_mask_irq_dma(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_DMAMASK);
>  	iomd_writeb(val & ~mask, IOMD_DMAMASK);
>  }
>  
> -static void iomd_unmask_irq_dma(unsigned int irq)
> +static void iomd_unmask_irq_dma(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_DMAMASK);
>  	iomd_writeb(val | mask, IOMD_DMAMASK);
>  }
>  
>  static struct irq_chip iomd_dma_chip = {
> -	.ack	= iomd_mask_irq_dma,
> -	.mask	= iomd_mask_irq_dma,
> -	.unmask = iomd_unmask_irq_dma,
> +	.irq_ack	= iomd_mask_irq_dma,
> +	.irq_mask	= iomd_mask_irq_dma,
> +	.irq_unmask	= iomd_unmask_irq_dma,
>  };
>  
> -static void iomd_mask_irq_fiq(unsigned int irq)
> +static void iomd_mask_irq_fiq(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_FIQMASK);
>  	iomd_writeb(val & ~mask, IOMD_FIQMASK);
>  }
>  
> -static void iomd_unmask_irq_fiq(unsigned int irq)
> +static void iomd_unmask_irq_fiq(struct irq_data *d)
>  {
>  	unsigned int val, mask;
>  
> -	mask = 1 << (irq & 7);
> +	mask = 1 << (d->irq & 7);
>  	val = iomd_readb(IOMD_FIQMASK);
>  	iomd_writeb(val | mask, IOMD_FIQMASK);
>  }
>  
>  static struct irq_chip iomd_fiq_chip = {
> -	.ack	= iomd_mask_irq_fiq,
> -	.mask	= iomd_mask_irq_fiq,
> -	.unmask = iomd_unmask_irq_fiq,
> +	.irq_ack	= iomd_mask_irq_fiq,
> +	.irq_mask	= iomd_mask_irq_fiq,
> +	.irq_unmask	= iomd_unmask_irq_fiq,
>  };
>  
>  void __init rpc_init_irq(void)
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
