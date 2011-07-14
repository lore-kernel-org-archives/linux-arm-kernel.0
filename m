From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 14 Jul 2011 10:50:38 +0530
Subject: [PATCH 1/4] ARM: davinci: Check for NULL return from
	irq_alloc_generic_chip
In-Reply-To: <1310509910-4244-1-git-send-email-toddpoynor@google.com>
References: <1310509910-4244-1-git-send-email-toddpoynor@google.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DB11B2B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Todd,

On Wed, Jul 13, 2011 at 04:01:50, Todd Poynor wrote:
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Can you please include some patch description
(even if it turns out to be a restatement of
patch headline)?

Also, in general, including some background on how
you discovered the issue and how it affected you
can help determine the priority of the fix.

Thanks,
Sekhar

> ---
>  arch/arm/mach-davinci/irq.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index bfe68ec..ab7f688 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -52,6 +52,13 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
>  	struct irq_chip_type *ct;
>  
>  	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
> +
> +	if (!gc) {
> +		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
> +		       __func__, irq_start);
> +		return;
> +	}
> +
>  	ct = gc->chip_types;
>  	ct->chip.irq_ack = irq_gc_ack;
>  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> -- 
> 1.7.3.1
> 
> 
