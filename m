From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 12:37:18 +0900
Subject: [PATCH] ARM: S3C64XX: Remove unconditional power domain disables
In-Reply-To: <1325071546-28711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325071546-28711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <029001ccc5db$2a8a5400$7f9efc00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Now that we have software runtime power management support this code is
> redundant.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/pm.c |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> index 055dac9..7d3e81b 100644
> --- a/arch/arm/mach-s3c64xx/pm.c
> +++ b/arch/arm/mach-s3c64xx/pm.c
> @@ -346,23 +346,10 @@ int __init s3c64xx_pm_init(void)
> 
>  static __init int s3c64xx_pm_initcall(void)
>  {
> -	u32 val;
> -
>  	pm_cpu_prep = s3c64xx_pm_prepare;
>  	pm_cpu_sleep = s3c64xx_cpu_suspend;
>  	pm_uart_udivslot = 1;
> 
> -	/*
> -	 * Unconditionally disable power domains that contain only
> -	 * blocks which have no mainline driver support.
> -	 */
> -	val = __raw_readl(S3C64XX_NORMAL_CFG);
> -	val &= ~(S3C64XX_NORMALCFG_DOMAIN_G_ON |
> -		 S3C64XX_NORMALCFG_DOMAIN_V_ON |
> -		 S3C64XX_NORMALCFG_DOMAIN_I_ON |
> -		 S3C64XX_NORMALCFG_DOMAIN_P_ON);
> -	__raw_writel(val, S3C64XX_NORMAL_CFG);
> -
>  #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
>  	gpio_request(S3C64XX_GPN(12), "DEBUG_LED0");
>  	gpio_request(S3C64XX_GPN(13), "DEBUG_LED1");
> --
> 1.7.7.3

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
