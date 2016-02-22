From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 22 Feb 2016 09:17:13 -0800
Subject: [PATCH 11/61] gpio: bcm-kona: Use devm_gpiochip_add_data() for
 gpio registration
In-Reply-To: <1456150130-2668-12-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <1456150130-2668-12-git-send-email-ldewangan@nvidia.com>
Message-ID: <67faee9e-e234-fc60-5465-3193bed4a7c3@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/22/2016 6:08 AM, Laxman Dewangan wrote:
> Use devm_gpiochip_add_data() for GPIO registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Ray Jui <rjui@broadcom.com>
> ---
>  drivers/gpio/gpio-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index b6c5abe..2fd38d5 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -630,7 +630,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>
>  	bcm_kona_gpio_reset(kona_gpio);
>
> -	ret = gpiochip_add_data(chip, kona_gpio);
> +	ret = devm_gpiochip_add_data(dev, chip, kona_gpio);
>  	if (ret < 0) {
>  		dev_err(dev, "Couldn't add GPIO chip -- %d\n", ret);
>  		goto err_irq_domain;
>

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks!
