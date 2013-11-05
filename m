From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 5 Nov 2013 10:52:44 +0100
Subject: [PATCH 3/4] pinctrl: at91: copy define to driver
In-Reply-To: <1383643814-14308-1-git-send-email-linus.walleij@linaro.org>
References: <1383643814-14308-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5278BFEC.4070600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2013 10:30, Linus Walleij :
> The #define for the maximum number of GPIO blocks was retrieved
> into pinctrl-at91.c by implicit inclusion of <mach/gpio.h>
> from <linux/gpio.h> creating a dependency on machine-local
> <mach/gpio.h>. Break the depenency by copying this single
> define into the driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Yes, that seems reasonable.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> This will be applied directly to the pinctrl tree unless there
> are specific protests.
> ---
>   drivers/pinctrl/pinctrl-at91.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index f350fd2e170e..0dfb8c7b58df 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -33,6 +33,7 @@
>
>   #include "core.h"
>
> +#define MAX_GPIO_BANKS		5
>   #define MAX_NB_GPIO_PER_BANK	32
>
>   struct at91_pinctrl_mux_ops;
>


-- 
Nicolas Ferre
