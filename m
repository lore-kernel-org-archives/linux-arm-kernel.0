From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 10 Jan 2011 15:04:58 +0300
Subject: [PATCH 5/5] ARM: pxa: Fix recursive call of
	pxa_(un)mask_low_gpio()
In-Reply-To: <1294615746-27668-5-git-send-email-marek.vasut@gmail.com>
References: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
	<1294615746-27668-5-git-send-email-marek.vasut@gmail.com>
Message-ID: <4D2AF5EA.6050104@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-01-2011 2:29, Marek Vasut wrote:

> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
[...]

> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 81edf97..96571fe 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -112,14 +112,14 @@ static void pxa_mask_low_gpio(unsigned int irq)
>   {
>   	struct irq_desc *desc = irq_to_desc(irq);

    You should have removed that variable too as it's not unused.

> -	desc->chip->mask(irq);
> +	pxa_mask_irq(irq);
>   }
>
>   static void pxa_unmask_low_gpio(unsigned int irq)
>   {
>   	struct irq_desc *desc = irq_to_desc(irq);

    Same here...

> -	desc->chip->unmask(irq);
> +	pxa_unmask_irq(irq);
>   }

WBR, Sergei
