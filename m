From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 4 Jun 2014 15:42:06 +0200 (CEST)
Subject: [PATCH] irqchip: nvic: Use the generic noop function
In-Reply-To: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
References: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.10.1406041540530.3319@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jun 2014, Daniel Thompson wrote:

> Using the generic function saves looking up this custom one in a source
> navigator.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/irqchip/irq-nvic.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 70bdf6e..c935c61 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -49,14 +49,6 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>  	handle_IRQ(irq, regs);
>  }
>  
> -static void nvic_eoi(struct irq_data *d)
> -{
> -	/*
> -	 * This is a no-op as end of interrupt is signaled by the exception
> -	 * return sequence.
> -	 */

You shred that information. Please move the comment above the
irq_gc_noop assignment.

Thanks,

	tglx
