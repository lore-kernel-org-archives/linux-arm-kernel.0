From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 05 May 2016 23:36:49 +0200
Subject: [PATCH v7 5/9] i2c: rk3x: Change SoC data to not use array
In-Reply-To: <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <2061861.OMNZ1I2HYA@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 4. Mai 2016, 22:33:38 schrieb David Wu:
> Signed-off-by: David Wu <david.wu@rock-chips.com>

that makes the code look nicer (and of course prepares for you further 
changes), so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/i2c/busses/i2c-rk3x.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 0838fcf..9686c81 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -867,17 +867,39 @@ static const struct i2c_algorithm rk3x_i2c_algorithm =
> { .functionality		= rk3x_i2c_func,
>  };
> 
> -static struct rk3x_i2c_soc_data soc_data[3] = {
> -	{ .grf_offset = 0x154 }, /* rk3066 */
> -	{ .grf_offset = 0x0a4 }, /* rk3188 */
> -	{ .grf_offset = -1 },    /* no I2C switching needed */
> +static const struct rk3x_i2c_soc_data rk3066_soc_data = {
> +	.grf_offset = 0x154,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3188_soc_data = {
> +	.grf_offset = 0x0a4,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3228_soc_data = {
> +	.grf_offset = -1,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3288_soc_data = {
> +	.grf_offset = -1,
>  };
> 
>  static const struct of_device_id rk3x_i2c_match[] = {
> -	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
> -	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
> -	{ .compatible = "rockchip,rk3228-i2c", .data = (void *)&soc_data[2] },
> -	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
> +	{
> +		.compatible = "rockchip,rk3066-i2c",
> +		.data = (void *)&rk3066_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3188-i2c",
> +		.data = (void *)&rk3188_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3228-i2c",
> +		.data = (void *)&rk3228_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3288-i2c",
> +		.data = (void *)&rk3288_soc_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
