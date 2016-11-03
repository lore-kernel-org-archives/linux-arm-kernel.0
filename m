From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Nov 2016 16:55:45 +0100
Subject: [PATCH 2/6] pinctrl: rockchip: add support for rk1108
In-Reply-To: <1478176470-11956-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176470-11956-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <3450255.c5nv6dGt3I@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 20:34:30 schrieb Andy Yan:
> Add basic support for rk1108 soc
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

nice when support for a new soc is that easy in a driver :-)

There are two small issues below and with those fixed
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

missing devicetree binding update for the new compatible

> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 49bf7dc..9f324b1 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c

[...]

> +static struct rockchip_pin_ctrl rk1108_pin_ctrl = {
> +	.pin_banks		= rk1108_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rk1108_pin_banks),
> +	.label			= "RK1108-GPIO",
> +	.type			= RK1108,
> +	.grf_mux_offset		= 0x10,
> +	.pmu_mux_offset		= 0x0,
> +	.pull_calc_reg          = rk3288_calc_pull_reg_and_bit,

this last line has spaces instead of tabs between .pull_calc_reg and the "="


Heiko
