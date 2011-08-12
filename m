From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 18:22:34 +0900
Subject: [PATCH] ARM: EXYNOS4: Change the pwm device name to supprot clkdev
In-Reply-To: <1311661312-24470-1-git-send-email-jhbird.choi@samsung.com>
References: <1311661312-24470-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <007301cc58d1$6033d300$209b7900$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at samsung.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/mach-exynos4/time.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index
> ebb8f38..9a74294 100644
> --- a/arch/arm/mach-exynos4/time.c
> +++ b/arch/arm/mach-exynos4/time.c
> @@ -264,6 +264,7 @@ static void __init exynos4_timer_resources(void)
>  	clk_enable(timerclk);
> 
>  	tmpdev.id = 2;
> +	tmpdev.dev.init_name = "s3c24xx-pwm.2";
>  	tin2 = clk_get(&tmpdev.dev, "pwm-tin");
>  	if (IS_ERR(tin2))
>  		panic("failed to get pwm-tin2 clock for system timer"); @@ -
> 274,6 +275,7 @@ static void __init exynos4_timer_resources(void)
>  	clk_enable(tin2);
> 
>  	tmpdev.id = 4;
> +	tmpdev.dev.init_name = "s3c24xx-pwm.4";
>  	tin4 = clk_get(&tmpdev.dev, "pwm-tin");
>  	if (IS_ERR(tin4))
>  		panic("failed to get pwm-tin4 clock for system timer");
> --
> 1.7.0

This is not available now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
