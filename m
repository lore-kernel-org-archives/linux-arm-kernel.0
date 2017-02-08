From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Feb 2017 09:26:07 +0000
Subject: [PATCH v2 02/25] mfd: axp20x: correct name of temperature data
 ADC registers
In-Reply-To: <20170127085458.18270-3-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-3-quentin.schulz@free-electrons.com>
Message-ID: <20170208092607.qlzm7pt4w3wqempf@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jan 2017, Quentin Schulz wrote:

> The registers 0x56 and 0x57 of AXP22X PMIC store the value of the
> internal temperature of the PMIC.
> 
> This patch modifies the name of these registers from AXP22X_PMIC_ADC_H/L
> to AXP22X_PMIC_TEMP_H/L so their purpose is clearer.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v2
> 
>  drivers/mfd/axp20x.c       | 2 +-
>  include/linux/mfd/axp20x.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 619a83e..9c2fd37 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -102,7 +102,7 @@ static const struct regmap_range axp22x_volatile_ranges[] = {
>  	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
> -	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> +	regmap_reg_range(AXP22X_PMIC_TEMP_H, AXP20X_IPSOUT_V_HIGH_L),
>  	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
>  };
>  
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index a4860bc..5ecadbb 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -228,8 +228,8 @@ enum {
>  #define AXP20X_OCV_MAX			0xf
>  
>  /* AXP22X specific registers */
> -#define AXP22X_PMIC_ADC_H		0x56
> -#define AXP22X_PMIC_ADC_L		0x57
> +#define AXP22X_PMIC_TEMP_H		0x56
> +#define AXP22X_PMIC_TEMP_L		0x57
>  #define AXP22X_TS_ADC_H			0x58
>  #define AXP22X_TS_ADC_L			0x59
>  #define AXP22X_BATLOW_THRES1		0xe6

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
