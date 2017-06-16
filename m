From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 16 Jun 2017 16:17:45 +0800
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3328 Soc
In-Reply-To: <1495699104-137633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1495699104-137633-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <b11e5b39-dc90-ded5-f767-4058dffa85a8@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Ping.... :)

On 2017/5/25 15:58, Shawn Lin wrote:
> Disable IO function switching between sdmmc and jtag
> for RK3328 Soc.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/soc/rockchip/grf.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> index d61db34..15e71fd 100644
> --- a/drivers/soc/rockchip/grf.c
> +++ b/drivers/soc/rockchip/grf.c
> @@ -54,6 +54,17 @@ struct rockchip_grf_info {
>   	.num_values = ARRAY_SIZE(rk3288_defaults),
>   };
>   
> +#define RK3328_GRF_SOC_CON4		0x410
> +
> +static const struct rockchip_grf_value rk3328_defaults[] __initconst = {
> +	{ "jtag switching", RK3328_GRF_SOC_CON4, HIWORD_UPDATE(0, 1, 12) },
> +};
> +
> +static const struct rockchip_grf_info rk3328_grf __initconst = {
> +	.values = rk3328_defaults,
> +	.num_values = ARRAY_SIZE(rk3328_defaults),
> +};
> +
>   #define RK3368_GRF_SOC_CON15		0x43c
>   
>   static const struct rockchip_grf_value rk3368_defaults[] __initconst = {
> @@ -84,6 +95,9 @@ struct rockchip_grf_info {
>   		.compatible = "rockchip,rk3288-grf",
>   		.data = (void *)&rk3288_grf,
>   	}, {
> +		.compatible = "rockchip,rk3328-grf",
> +		.data = (void *)&rk3328_grf,
> +	}, {
>   		.compatible = "rockchip,rk3368-grf",
>   		.data = (void *)&rk3368_grf,
>   	}, {
> 
