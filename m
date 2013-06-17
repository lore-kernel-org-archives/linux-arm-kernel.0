From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 15:19:59 +0200
Subject: [PATCH 1/3] gpio: samsung: add PINCTRL_S3C24XX to exclude options
In-Reply-To: <201306140045.27744.heiko@sntech.de>
References: <201306140044.15568.heiko@sntech.de>
 <201306140045.27744.heiko@sntech.de>
Message-ID: <1825186.C6XXUYx8Nl@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Friday 14 of June 2013 00:45:27 Heiko St?bner wrote:
> When a pinctrl driver is loaded legacy gpio support has to be disabled.
> The code checking for the pinctrl presence is contained in an #ifdef
> checking for the presence of a valid samsung pinctrl driver.
> 
> There the new PINCTRL_S3C24XX was missing resulting in the check never
> being run and the gpio being enabled breaking the pinctrl driver.
> 
> Fix this by adding the missing CONFIG_PINCTRL_S3C24XX
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpio/gpio-samsung.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> index a1392f4..c84503e 100644
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@ -2949,7 +2949,8 @@ static __init int samsung_gpiolib_init(void)
>  	int i, nr_chips;
>  	int group = 0;
> 
> -#if defined(CONFIG_PINCTRL_EXYNOS) || defined(CONFIG_PINCTRL_EXYNOS5440)
> +#if defined(CONFIG_PINCTRL_EXYNOS) || defined(CONFIG_PINCTRL_EXYNOS5440) ||
> \ +    defined(CONFIG_PINCTRL_S3C24XX)

I wonder if this wouldn't be simply covered by PINCTRL_SAMSUNG (except 
PINCTRL_EXYNOS5440 which doesn't use the common part).

Best regards,
Tomasz

>  	/*
>  	* This gpio driver includes support for device tree support and there
>  	* are platforms using it. In order to maintain compatibility with those
