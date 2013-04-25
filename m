From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Apr 2013 11:35:28 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
In-Reply-To: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5178F8E0.6010606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 04:41 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Kim and Ben,

It is the last patch in the series which was not acked-by.
Rafael is willing to take it in its tree if you ack it.

Are you ok if this patch ?

Thanks
-- Daniel

>  arch/arm/mach-s3c64xx/cpuidle.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
> index 852ff16..3c8ab07 100644
> --- a/arch/arm/mach-s3c64xx/cpuidle.c
> +++ b/arch/arm/mach-s3c64xx/cpuidle.c
> @@ -40,8 +40,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
> -
>  static struct cpuidle_driver s3c64xx_cpuidle_driver = {
>  	.name	= "s3c64xx_cpuidle",
>  	.owner  = THIS_MODULE,
> @@ -60,16 +58,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
>  
>  static int __init s3c64xx_init_cpuidle(void)
>  {
> -	int ret;
> -
> -	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
> -
> -	ret = cpuidle_register_device(&s3c64xx_cpuidle_device);
> -	if (ret) {
> -		pr_err("Failed to register cpuidle device: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
>  }
>  device_initcall(s3c64xx_init_cpuidle);


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
