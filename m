From: albeu@free.fr (Alban)
Date: Mon, 22 Feb 2016 21:13:23 +0100
Subject: [PATCH 10/61] gpio: ath79: Use devm_gpiochip_add_data() for
 gpio registration
In-Reply-To: <1456150130-2668-11-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <1456150130-2668-11-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160222211323.5c10533f@tock>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Feb 2016 19:37:59 +0530
Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Use devm_gpiochip_add_data() for GPIO registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Alban Bedel <albeu@free.fr>
> ---
>  drivers/gpio/gpio-ath79.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
> index d13dd13..a6aad59 100644
> --- a/drivers/gpio/gpio-ath79.c
> +++ b/drivers/gpio/gpio-ath79.c
> @@ -182,7 +182,7 @@ static int ath79_gpio_probe(struct platform_device *pdev)
>  		ctrl->chip.direction_output = ar934x_gpio_direction_output;
>  	}
>  
> -	err = gpiochip_add_data(&ctrl->chip, ctrl);
> +	err = devm_gpiochip_add_data(&pdev->dev, &ctrl->chip, ctrl);
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"cannot add AR71xx GPIO chip, error=%d", err);

With the patches already applied to the devel branch a few more changes
will be needed to remove the calls to gpiochip_remove() in the probe
error path and the remove callback.

Alban
