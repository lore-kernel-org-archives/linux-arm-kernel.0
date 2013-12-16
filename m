From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Dec 2013 10:57:11 +0100
Subject: [PATCH 2/2] pinctrl: at91: replace clk_prepare + clk_enable by
 clk_prepare_enable
In-Reply-To: <1387132252-2584-3-git-send-email-b.brezillon@overkiz.com>
References: <1387132252-2584-1-git-send-email-b.brezillon@overkiz.com>
 <1387132252-2584-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52AECE77.9000601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2013 19:30, Boris BREZILLON :
> Replace the clk_prepare and clk_enable calls by a single
> clk_prepare_enable call.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/pinctrl/pinctrl-at91.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 82f6301..4deb9cb 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1359,10 +1359,8 @@ void at91_pinctrl_gpio_resume(void)
>  
>  		pio = gpio_chips[i]->regbase;
>  
> -		if (!wakeups[i]) {
> -			if (clk_prepare(gpio_chips[i]->clock) == 0)
> -				clk_enable(gpio_chips[i]->clock);
> -		}
> +		if (!wakeups[i])
> +			clk_prepare_enable(gpio_chips[i]->clock);
>  
>  		__raw_writel(wakeups[i], pio + PIO_IDR);
>  		__raw_writel(backups[i], pio + PIO_IER);
> 


-- 
Nicolas Ferre
