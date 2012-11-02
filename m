From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 1 Nov 2012 17:31:51 -0700
Subject: [PATCH] hwmon: Only include of_match_table with CONFIG_OF_GPIO
In-Reply-To: <1351814143-13714-1-git-send-email-jm@lentin.co.uk>
References: <1351814143-13714-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20121102003151.GA6197@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 11:55:43PM +0000, Jamie Lentin wrote:
> The following fixes build errors on sparc. Without any DT support,
> of_match_ptr is NULL and the below is a no-op. However, if just
> CONFIG_OF is defined then so is of_match_ptr.
> 
> All useful parts of the gpio-fan DT support rely on CONFIG_OF_GPIO
> anyway, so of_match_table should too.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  drivers/hwmon/gpio-fan.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index 36509ae..1381a2e 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -630,7 +630,9 @@ static struct platform_driver gpio_fan_driver = {
>  	.driver	= {
>  		.name	= "gpio-fan",
>  		.pm	= GPIO_FAN_PM,
> +#ifdef CONFIG_OF_GPIO
>  		.of_match_table = of_match_ptr(of_gpio_fan_match),
> +#endif
>  	},
Applied.

Thanks,
Guenter
