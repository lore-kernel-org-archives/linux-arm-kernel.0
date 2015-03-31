From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 31 Mar 2015 02:27:09 +0200
Subject: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate Exynos3250 into
 S3C6410
In-Reply-To: <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150331002709.GF3849@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c

On 30/03/2015 at 17:19:32 +0200, Krzysztof Kozlowski wrote :
> There are now no differences between RTC on Exynos3250 and S3C6410.
> Merge everything into one so duplicated code could be removed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-s3c.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index fb0c569765c6..5e162eaad277 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -774,18 +774,6 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
>  	.disable		= s3c6410_rtc_disable,
>  };
>  
> -static struct s3c_rtc_data const exynos3250_rtc_data = {
> -	.max_user_freq		= 32768,
> -	.needs_src_clk		= true,
> -	.irq_handler		= s3c6410_rtc_irq,
> -	.set_freq		= s3c6410_rtc_setfreq,
> -	.enable_tick		= s3c6410_rtc_enable_tick,
> -	.save_tick_cnt		= s3c6410_rtc_save_tick_cnt,
> -	.restore_tick_cnt	= s3c6410_rtc_restore_tick_cnt,
> -	.enable			= s3c24xx_rtc_enable,
> -	.disable		= s3c6410_rtc_disable,
> -};
> -
>  static const struct of_device_id s3c_rtc_dt_match[] = {
>  	{
>  		.compatible = "samsung,s3c2410-rtc",
> @@ -801,7 +789,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
>  		.data = (void *)&s3c6410_rtc_data,
>  	}, {
>  		.compatible = "samsung,exynos3250-rtc",
> -		.data = (void *)&exynos3250_rtc_data,
> +		.data = (void *)&s3c6410_rtc_data,
>  	},
>  	{ /* sentinel */ },
>  };
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
