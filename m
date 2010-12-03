From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 17:25:13 +0000
Subject: [PATCH 19/54] ARM: integrator: irq_data conversion.
In-Reply-To: <20101130133644.GT15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133644.GT15575@mail.wantstofly.org>
Message-ID: <20101203172513.GH30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:36:44PM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mach-integrator/integrator_ap.c |   16 +++++-----
>  arch/arm/mach-integrator/integrator_cp.c |   48 +++++++++++++++---------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 548208f..ca363c1 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -156,21 +156,21 @@ static void __init ap_map_io(void)
>  
>  #define INTEGRATOR_SC_VALID_INT	0x003fffff
>  
> -static void sc_mask_irq(unsigned int irq)
> +static void sc_mask_irq(struct irq_data *d)
>  {
> -	writel(1 << irq, VA_IC_BASE + IRQ_ENABLE_CLEAR);
> +	writel(1 << d->irq, VA_IC_BASE + IRQ_ENABLE_CLEAR);
>  }
>  
> -static void sc_unmask_irq(unsigned int irq)
> +static void sc_unmask_irq(struct irq_data *d)
>  {
> -	writel(1 << irq, VA_IC_BASE + IRQ_ENABLE_SET);
> +	writel(1 << d->irq, VA_IC_BASE + IRQ_ENABLE_SET);
>  }
>  
>  static struct irq_chip sc_chip = {
> -	.name	= "SC",
> -	.ack	= sc_mask_irq,
> -	.mask	= sc_mask_irq,
> -	.unmask = sc_unmask_irq,
> +	.name		= "SC",
> +	.irq_ack	= sc_mask_irq,
> +	.irq_mask	= sc_mask_irq,
> +	.irq_unmask	= sc_unmask_irq,
>  };
>  
>  static void __init ap_init_irq(void)
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index 6258c90..f0f16d4 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -147,61 +147,61 @@ static void __init intcp_map_io(void)
>  #define sic_writel	__raw_writel
>  #define sic_readl	__raw_readl
>  
> -static void cic_mask_irq(unsigned int irq)
> +static void cic_mask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_CIC_START;
> +	unsigned int irq = d->irq - IRQ_CIC_START;
>  	cic_writel(1 << irq, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
>  }
>  
> -static void cic_unmask_irq(unsigned int irq)
> +static void cic_unmask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_CIC_START;
> +	unsigned int irq = d->irq - IRQ_CIC_START;
>  	cic_writel(1 << irq, INTCP_VA_CIC_BASE + IRQ_ENABLE_SET);
>  }
>  
>  static struct irq_chip cic_chip = {
> -	.name	= "CIC",
> -	.ack	= cic_mask_irq,
> -	.mask	= cic_mask_irq,
> -	.unmask	= cic_unmask_irq,
> +	.name		= "CIC",
> +	.irq_ack	= cic_mask_irq,
> +	.irq_mask	= cic_mask_irq,
> +	.irq_unmask	= cic_unmask_irq,
>  };
>  
> -static void pic_mask_irq(unsigned int irq)
> +static void pic_mask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_PIC_START;
> +	unsigned int irq = d->irq - IRQ_PIC_START;
>  	pic_writel(1 << irq, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
>  }
>  
> -static void pic_unmask_irq(unsigned int irq)
> +static void pic_unmask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_PIC_START;
> +	unsigned int irq = d->irq - IRQ_PIC_START;
>  	pic_writel(1 << irq, INTCP_VA_PIC_BASE + IRQ_ENABLE_SET);
>  }
>  
>  static struct irq_chip pic_chip = {
> -	.name	= "PIC",
> -	.ack	= pic_mask_irq,
> -	.mask	= pic_mask_irq,
> -	.unmask = pic_unmask_irq,
> +	.name		= "PIC",
> +	.irq_ack	= pic_mask_irq,
> +	.irq_mask	= pic_mask_irq,
> +	.irq_unmask	= pic_unmask_irq,
>  };
>  
> -static void sic_mask_irq(unsigned int irq)
> +static void sic_mask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;
>  	sic_writel(1 << irq, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
>  }
>  
> -static void sic_unmask_irq(unsigned int irq)
> +static void sic_unmask_irq(struct irq_data *d)
>  {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;
>  	sic_writel(1 << irq, INTCP_VA_SIC_BASE + IRQ_ENABLE_SET);
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
