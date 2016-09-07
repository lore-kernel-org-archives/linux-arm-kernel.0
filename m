From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 7 Sep 2016 11:59:08 +0200
Subject: [PATCH] pinctrl/at91: Don't provide a default trigger type
In-Reply-To: <1473170295-16712-1-git-send-email-marc.zyngier@arm.com>
References: <1473170295-16712-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <97541e82-fe22-f6c0-075a-034ba821227c@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/09/2016 ? 15:58, Marc Zyngier a ?crit :
> at91 used to set a default trigger type for GPIO interrupts in
> order to cope with the old board files. These days are long gone,
> and it all gets probed through DT.
> 
> Andras Szemzo reported that the Ethernet device on his board was
> bailing to be probed, due to a conflict in interrupt trigger.
> Surely enough, this is due to this default trigger still being
> present, and turning this into a IRQ_TYPE_NONE fixes the issue.
> 
> Reported-by: Andras Szemzo <szemzo.andras@gmail.com>
> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,

> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 80daead..9f09041 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1614,7 +1614,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
>  				   &gpio_irqchip,
>  				   0,
>  				   handle_edge_irq,
> -				   IRQ_TYPE_EDGE_BOTH);
> +				   IRQ_TYPE_NONE);
>  	if (ret) {
>  		dev_err(&pdev->dev, "at91_gpio.%d: Couldn't add irqchip to gpiochip.\n",
>  			at91_gpio->pioc_idx);
> 


-- 
Nicolas Ferre
