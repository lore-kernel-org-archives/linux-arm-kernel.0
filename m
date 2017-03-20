From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Mar 2017 10:44:16 +0000
Subject: [RESEND PATCH v4 9/9] mfd: axp20x: add CHRG_CTRL1/2/3 to
 writeable regs for AXP20X/AXP22X
In-Reply-To: <20170320081653.8884-10-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-10-quentin.schulz@free-electrons.com>
Message-ID: <20170320104416.ph2wbvsie5tj53up@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Mar 2017, Quentin Schulz wrote:

> The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
> different battery charging settings such as the constant current charge
> value.
> 
> The AXP22X also have a third register CHRG_CTRL3 which has settings for
> battery charging too.
> 
> This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
> list of writeable registers for AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v2:
>  - added AXP20X_CHRG_CTRL2 and AXP20X_CHRG_CTRL3 to the writeable
>  registers table,
>  - removed added reg range for ADC data in volatile regs range,
> 
>  drivers/mfd/axp20x.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 37643b1..5ba3b04 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -68,6 +68,7 @@ static const struct regmap_access_table axp152_volatile_table = {
>  
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>  	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
> @@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP22X_CHRG_CTRL3),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
