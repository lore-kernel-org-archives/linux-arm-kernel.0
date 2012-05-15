From: riverful.kim@samsung.com (HeungJun, Kim)
Date: Tue, 15 May 2012 13:04:03 +0900
Subject: Exynos4: Fix the I2C.0 platform device's ID to 0 in the devs.c
In-Reply-To: <1335785096-5430-1-git-send-email-riverful.kim@samsung.com>
References: <1335785096-5430-1-git-send-email-riverful.kim@samsung.com>
Message-ID: <002a01cd324f$c4384680$4ca8d380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and Ping again?

> -----Original Message-----
> From: HeungJun, Kim [mailto:riverful.kim at samsung.com]
> Sent: Monday, April 30, 2012 8:25 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; HeungJun, Kim; Kyungmin Park
> Subject: ARM: Exynos4: Fix the I2C.0 platform device's ID to 0 in the devs.c
> 
> From: "HeungJun, Kim" <riverful.kim@samsung.com>
> 
> The #ifdef of CONFIG_S3C_DEV_I2C1 in devs.c, occurs to fail to get I2C0
adapter.
> So, this patch removes #ifdef, and fixes 0 when I2C0 devices.
> 
> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/devs.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index db32ec5..964a866 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -491,11 +491,7 @@ static struct resource s3c_i2c0_resource[] = {
> 
>  struct platform_device s3c_device_i2c0 = {
>  	.name		= "s3c2410-i2c",
> -#ifdef CONFIG_S3C_DEV_I2C1
>  	.id		= 0,
> -#else
> -	.id		= -1,
> -#endif
>  	.num_resources	= ARRAY_SIZE(s3c_i2c0_resource),
>  	.resource	= s3c_i2c0_resource,
>  };
> --
> 1.7.5.4
