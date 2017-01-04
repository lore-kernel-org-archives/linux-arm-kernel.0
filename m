From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jan 2017 11:55:39 +0000
Subject: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs
 for AXP22X
In-Reply-To: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-3-quentin.schulz@free-electrons.com>
Message-ID: <20170104115539.GA24058@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Jan 2017, Quentin Schulz wrote:

> The AXP22X PMICs have multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
> 
> This adds the different ADC data registers to the volatile registers of
> the AXP22X PMIC.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> ---
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 619a83e..a33db5e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -100,6 +100,7 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
>  static const struct regmap_range axp22x_volatile_ranges[] = {
>  	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>  	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>  	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
