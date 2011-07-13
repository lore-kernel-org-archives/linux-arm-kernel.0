From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 13 Jul 2011 14:46:24 +0400
Subject: [PATCH 1/4] ARM: davinci: Check for NULL return from
	irq_alloc_generic_chip
In-Reply-To: <1310509910-4244-1-git-send-email-toddpoynor@google.com>
References: <1310509910-4244-1-git-send-email-toddpoynor@google.com>
Message-ID: <4E1D7780.9050505@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-07-2011 2:31, Todd Poynor wrote:

> Signed-off-by: Todd Poynor<toddpoynor@google.com>
> ---
>   arch/arm/mach-davinci/irq.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index bfe68ec..ab7f688 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -52,6 +52,13 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
>   	struct irq_chip_type *ct;
>
>   	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
> +

    Remove this empty line please.

> +	if (!gc) {
> +		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
> +		       __func__, irq_start);
> +		return;
> +	}
> +
>   	ct = gc->chip_types;
>   	ct->chip.irq_ack = irq_gc_ack;
>   	ct->chip.irq_mask = irq_gc_mask_clr_bit;

WBR, Sergei
