From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 07:49:53 +0200
Subject: [PATCH 2/3] rtc: s3c: add device data for samsung,exynos3250-rtc
In-Reply-To: <1468056226-19128-3-git-send-email-ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
 <1468056226-19128-3-git-send-email-ayaka@soulik.info>
Message-ID: <57833381.7050503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2016 11:23 AM, Randy Li wrote:
> The device data for samsung,exynos3250-rtc and samsung,s3c6410-rtc
> are just have a difference, but keeping using the same device data
> would cause the platform using the other IP core not work.

I cannot understand what you wanted to say here. Please rephrase it.

Why not just reverting a42e6eae457837d6a5925f4926f5ba05ccf44f89?

Best regards,
Krzysztof

> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/rtc/rtc-s3c.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 5dc18ca..e9f6151 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -810,6 +810,18 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
>  	.disable		= s3c6410_rtc_disable,
>  };
>  
> +static struct s3c_rtc_data const exynos3250_rtc_data = {
> +	.max_user_freq		= 32768,
> +	.needs_src_clk          = true,
> +	.irq_handler		= s3c6410_rtc_irq,
> +	.set_freq		= s3c6410_rtc_setfreq,
> +	.enable_tick		= s3c6410_rtc_enable_tick,
> +	.save_tick_cnt		= s3c6410_rtc_save_tick_cnt,
> +	.restore_tick_cnt	= s3c6410_rtc_restore_tick_cnt,
> +	.enable			= s3c24xx_rtc_enable,
> +	.disable		= s3c6410_rtc_disable,
> +};
> +
>  static const struct of_device_id s3c_rtc_dt_match[] = {
>  	{
>  		.compatible = "samsung,s3c2410-rtc",
> @@ -825,7 +837,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
>  		.data = (void *)&s3c6410_rtc_data,
>  	}, {
>  		.compatible = "samsung,exynos3250-rtc",
> -		.data = (void *)&s3c6410_rtc_data,
> +		.data = (void *)&exynos3250_rtc_data,
>  	},
>  	{ /* sentinel */ },
>  };
> 
