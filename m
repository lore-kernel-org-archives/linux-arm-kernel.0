From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 12 Oct 2012 16:04:12 +0200
Subject: [PATCH 1/1] pinctrl/at91: fix compatible order
In-Reply-To: <1350033790-31028-1-git-send-email-plagnioj@jcrosoft.com>
References: <1350033790-31028-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <5078235C.1040204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/12/2012 11:23 AM, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> the sam9x5 is new version of the rm9200 not the invert
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/pinctrl/pinctrl-at91.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 9c0fe11..bdb152b 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1331,8 +1331,8 @@ static void __devinit at91_gpio_probe_fixup(void)
>   }
>
>   static struct of_device_id at91_gpio_of_match[] __devinitdata = {
> -	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
>   	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
> +	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
>   	{ /* sentinel */ }
>   };
>
>


Do it also for at91_pinctrl_of_match[], there is the same issue.

Regards

Ludovic
