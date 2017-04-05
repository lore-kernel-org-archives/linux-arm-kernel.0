From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Apr 2017 09:59:52 +0100
Subject: [PATCH v5 3/7] mfd: axp20x: add MFD cells for AXP20X and AXP22X
 battery driver
In-Reply-To: <20170405081059.1684-4-quentin.schulz@free-electrons.com>
References: <20170405081059.1684-1-quentin.schulz@free-electrons.com>
 <20170405081059.1684-4-quentin.schulz@free-electrons.com>
Message-ID: <20170405085952.sfsqmew2d37jr6ql@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Apr 2017, Quentin Schulz wrote:

> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> 
> This patch adds the AXP20X/AXP22X battery driver to the MFD cells of the
> AXP209, AXP221 and AXP223 MFD.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> v2:
>  - changed DT node name from battery_power_supply to
>  battery-power-supply,
>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>  done in the IIO ADC driver now),
> 
>  drivers/mfd/axp20x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 5ba3b04..e6f5507 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -594,6 +594,9 @@ static struct mfd_cell axp20x_cells[] = {
>  	}, {
>  		.name		= "axp20x-adc",
>  	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp209-battery-power-supply",
> +	}, {
>  		.name		= "axp20x-ac-power-supply",
>  		.of_compatible	= "x-powers,axp202-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> @@ -621,6 +624,9 @@ static struct mfd_cell axp221_cells[] = {
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
>  	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp221-battery-power-supply",
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -636,6 +642,9 @@ static struct mfd_cell axp223_cells[] = {
>  	}, {
>  		.name		= "axp22x-adc",
>  	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp221-battery-power-supply",
> +	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
>  		.name		= "axp20x-ac-power-supply",

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
