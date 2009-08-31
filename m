From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 31 Aug 2009 19:34:51 +0200
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <1251739561-28972-3-git-send-email-sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<1251739561-28972-2-git-send-email-sleep_walker@suse.cz>
	<1251739561-28972-3-git-send-email-sleep_walker@suse.cz>
Message-ID: <200908311934.51750.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 31. srpna 2009 19:25:58 Tom?? ?ech napsal(a):
> From: Tom?? ?ech <sleep walker@suse.cz>
>
>
> Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
> ---
>  arch/arm/mach-pxa/treo680.c |   10 +---------
>  1 files changed, 1 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
> index 050ad8e..57bccc3 100644
> --- a/arch/arm/mach-pxa/treo680.c
> +++ b/arch/arm/mach-pxa/treo680.c
> @@ -254,16 +254,9 @@ static int treo680_backlight_init(struct device *dev)
>  	ret = gpio_direction_output(GPIO_NR_TREO680_BL_POWER, 0);
>  	if (ret)
>  		goto err2;
> -	ret = gpio_request(GPIO_NR_TREO680_LCD_POWER, "LCD POWER");
> -	if (ret)
> -		goto err2;
> -	ret = gpio_direction_output(GPIO_NR_TREO680_LCD_POWER, 0);
> -	if (ret)
> -		goto err3;
>
>  	return 0;
> -err3:
> -	gpio_free(GPIO_NR_TREO680_LCD_POWER);
> +
>  err2:
>  	gpio_free(GPIO_NR_TREO680_BL_POWER);
>  err:
> @@ -279,7 +272,6 @@ static int treo680_backlight_notify(int brightness)
>  static void treo680_backlight_exit(struct device *dev)
>  {
>  	gpio_free(GPIO_NR_TREO680_BL_POWER);
> -	gpio_free(GPIO_NR_TREO680_LCD_POWER);
>  }
>
>  static struct platform_pwm_backlight_data treo680_backlight_data = {

Why was that GPIO there before then? Does this have any effect on the boot 
problems you are experiencing with Centro/T680? Otherwise seems OK to me

Acked-by: Marek Vasut <marek.vasut@gmail.com>
