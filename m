From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 05 Aug 2015 18:36:06 +0800
Subject: [PATCH v3 1/3] ARM: rockchip: rename osc_switch_to_32k variable
In-Reply-To: <2128609.Kb18M8K28F@diego>
References: <2128609.Kb18M8K28F@diego>
Message-ID: <55C1E716.4010901@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/05/2015 06:50 AM, Heiko St?bner wrote:
> The variable name is misleading, as the deep suspend mode always switches
> the main supplying clock to the 32kHz source. Additionally the main
> oscillator remain running in some cases, which this var indicates.
>
> So rename it to osc_disable to clarity.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index 892bace..2ca1170 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -96,7 +96,7 @@ static bool rk3288_slp_disable_osc(void)
>   static void rk3288_slp_mode_set(int level)
>   {
>   	u32 mode_set, mode_set1;
> -	bool osc_switch_to_32k = rk3288_slp_disable_osc();
> +	bool osc_disable = rk3288_slp_disable_osc();
>   
>   	regmap_read(sgrf_regmap, RK3288_SGRF_CPU_CON0, &rk3288_sgrf_cpu_con0);
>   	regmap_read(sgrf_regmap, RK3288_SGRF_SOC_CON0, &rk3288_sgrf_soc_con0);
> @@ -140,7 +140,7 @@ static void rk3288_slp_mode_set(int level)
>   			    BIT(PMU_DDR1IO_RET_EN) | BIT(PMU_DDR0IO_RET_EN) |
>   			    BIT(PMU_ALIVE_USE_LF) | BIT(PMU_PLL_PD_EN);
>   
> -		if (osc_switch_to_32k)
> +		if (osc_disable)
>   			mode_set |= BIT(PMU_OSC_24M_DIS);
>   
>   		mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Tested-by: Chris Zhong <zyw@rock-chips.com>
