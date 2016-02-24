From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 24 Feb 2016 10:30:34 -0800
Subject: [PATCH 07/50] pinctrl: nsp-gpio: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-8-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-8-git-send-email-ldewangan@nvidia.com>
Message-ID: <dbd2ae89-1e62-e7d3-58f0-681d26fee2c9@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/24/2016 5:15 AM, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> ---
>  drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> index ac90043..2873f73 100644
> --- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> @@ -609,7 +609,7 @@ static int nsp_gpio_register_pinconf(struct nsp_gpio *chip)
>  	pctldesc->npins = gc->ngpio;
>  	pctldesc->confops = &nsp_pconf_ops;
>
> -	chip->pctl = pinctrl_register(pctldesc, chip->dev, chip);
> +	chip->pctl = devm_pinctrl_register(chip->dev, pctldesc, chip);
>  	if (IS_ERR(chip->pctl)) {
>  		dev_err(chip->dev, "unable to register pinctrl device\n");
>  		return PTR_ERR(chip->pctl);
>

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks!

Ray
