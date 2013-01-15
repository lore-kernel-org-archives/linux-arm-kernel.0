From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 15 Jan 2013 09:01:49 +0530
Subject: [PATCH] ARM: EXYNOS: Remove wrong I2S0 clock from peril clock
In-Reply-To: <003501cd9d65$9611d060$c2357120$@samsung.com>
References: <003501cd9d65$9611d060$c2357120$@samsung.com>
Message-ID: <50F4CDA5.3090904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 04:09 PM, Sangsu Park wrote:
> Remove I2S0 clock from peril since peril doesn't have I2S0 clock for EXYNOS4.
> Audio Subsystem block has I2S0 clk.
> 
> Signed-off-by: sangsu <sangsu@sangsu-P560.(none)>
> ---
>  arch/arm/mach-exynos/clock-exynos4.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos4.c
> b/arch/arm/mach-exynos/clock-exynos4.c
> index 6a45c9a..fa8a134 100644
> --- a/arch/arm/mach-exynos/clock-exynos4.c
> +++ b/arch/arm/mach-exynos/clock-exynos4.c
> @@ -613,11 +613,6 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.ctrlbit	= (1 << 18),
>  	}, {
>  		.name		= "iis",
> -		.devname	= "samsung-i2s.0",
> -		.enable		= exynos4_clk_ip_peril_ctrl,
> -		.ctrlbit	= (1 << 19),
> -	}, {
> -		.name		= "iis",
>  		.devname	= "samsung-i2s.1",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 20),
> 

After this clock has been removed, I2S0 registration fails on EXYNOS4
based boards (clk_get for iis clock fails). The alternate clock from
Audio subsystem block is missing.

-- 
Tushar Behera
