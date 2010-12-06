From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 15:10:24 +0300
Subject: [PATCH 47/54] ARM: versatile: irq_data conversion.
In-Reply-To: <20101130134119.GV15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134119.GV15575@mail.wantstofly.org>
Message-ID: <4CFCD2B0.6090902@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-11-2010 16:41, Lennert Buytenhek wrote:

> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
[...]

> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index e38acb0..9b9b6fa 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -62,23 +62,23 @@
>   #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
>   #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
>
> -static void sic_mask_irq(unsigned int irq)
> +static void sic_mask_irq(struct irq_data *d)
>   {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;

    Perhaps should've inserted an empty line here...

>   	writel(1<<  irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
>   }
>
> -static void sic_unmask_irq(unsigned int irq)
> +static void sic_unmask_irq(struct irq_data *d)
>   {
> -	irq -= IRQ_SIC_START;
> +	unsigned int irq = d->irq - IRQ_SIC_START;

    Here too.

>   	writel(1<<  irq, VA_SIC_BASE + SIC_IRQ_ENABLE_SET);
>   }

WBR, Sergei
