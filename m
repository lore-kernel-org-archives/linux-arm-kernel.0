From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Mar 2017 10:43:45 +0000
Subject: [RESEND PATCH v4 3/9] mfd: axp20x: add ADC cells for AXP20X and
 AXP22X PMICs
In-Reply-To: <20170320081653.8884-4-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-4-quentin.schulz@free-electrons.com>
Message-ID: <20170320104345.3qjsv3j3cip7uj4i@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Mar 2017, Quentin Schulz wrote:

> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
> AXP221 and AXP223 MFD.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> v3:
>  - removed of_compatible as DT node has been removed,
>  - use different names to probe the ADC driver,
> 
>  drivers/mfd/axp20x.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index e02edf1..46bdd23 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -590,6 +590,8 @@ static struct mfd_cell axp20x_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-adc",
> +	}, {
>  		.name		= "axp20x-ac-power-supply",
>  		.of_compatible	= "x-powers,axp202-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> @@ -610,6 +612,8 @@ static struct mfd_cell axp221_cells[] = {
>  	}, {
>  		.name		= "axp20x-regulator",
>  	}, {
> +		.name		= "axp22x-adc"
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -623,6 +627,8 @@ static struct mfd_cell axp223_cells[] = {
>  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
>  		.resources		= axp22x_pek_resources,
>  	}, {
> +		.name		= "axp22x-adc",
> +	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
>  		.name		= "axp20x-usb-power-supply",

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
