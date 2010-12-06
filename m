From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 14:27:46 +0300
Subject: [PATCH 08/54] ARM: aaec2000: irq_data conversion.
In-Reply-To: <20101130132552.GI15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130132552.GI15575@mail.wantstofly.org>
Message-ID: <4CFCC8B2.6000208@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-11-2010 16:25, Lennert Buytenhek wrote:

> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
[...]

> diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
> index 3ef6833..f8465bd 100644
> --- a/arch/arm/mach-aaec2000/core.c
> +++ b/arch/arm/mach-aaec2000/core.c
> @@ -68,25 +68,25 @@ void __init aaec2000_map_io(void)
>   /*
>    * Interrupt handling routines
>    */
> -static void aaec2000_int_ack(unsigned int irq)
> +static void aaec2000_int_ack(struct irq_data *d)
>   {
> -	IRQ_INTSR = 1<<  irq;
> +	IRQ_INTSR = 1<<  d->irq;
>   }
>
> -static void aaec2000_int_mask(unsigned int irq)
> +static void aaec2000_int_mask(struct irq_data *d)
>   {
> -	IRQ_INTENC |= (1<<  irq);
> +	IRQ_INTENC |= (1<<  d->irq);
>   }
>
> -static void aaec2000_int_unmask(unsigned int irq)
> +static void aaec2000_int_unmask(struct irq_data *d)
>   {
> -	IRQ_INTENS |= (1<<  irq);
> +	IRQ_INTENS |= (1<<  d->irq);
>   }

    Probably could have dropped useless parens, while at it...

WBR, Sergei
