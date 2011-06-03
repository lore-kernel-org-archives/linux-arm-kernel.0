From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Jun 2011 16:20:05 -0700
Subject: [PATCH] ARM: exynos4: remove compiler
	warning:	'exynos4_pwm4_resume'
In-Reply-To: <20110602093052.GA16756@july>
References: <20110602093052.GA16756@july>
Message-ID: <4DE96C25.2040903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/11 02:30, Kyungmin Park wrote:
> From: Kyungmin Park<kyungmin.park@samsung.com>
>
> Remove compiler warning when no CONFIG_PM
>
> arch/arm/mach-exynos4/time.c:209: warning: 'exynos4_pwm4_resume' defined but not used
>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
> index 86b9fa0..ebb8f38 100644
> --- a/arch/arm/mach-exynos4/time.c
> +++ b/arch/arm/mach-exynos4/time.c
> @@ -206,6 +206,7 @@ static cycle_t exynos4_pwm4_read(struct clocksource *cs)
>   	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x40));
>   }
>
> +#ifdef CONFIG_PM
>   static void exynos4_pwm4_resume(struct clocksource *cs)
>   {
>   	unsigned long pclk;
> @@ -218,6 +219,7 @@ static void exynos4_pwm4_resume(struct clocksource *cs)
>   	exynos4_pwm_init(4, ~0);
>   	exynos4_pwm_start(4, 1);
>   }
> +#endif
>
>   struct clocksource pwm_clocksource = {
>   	.name		= "pwm_timer4",
>
OK, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
