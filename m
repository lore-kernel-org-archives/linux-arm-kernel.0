From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jun 2016 15:57:45 +0100
Subject: [PATCH v2 2/4] mfd: axp20x: Extend axp22x_volatile_ranges
In-Reply-To: <1464887936-17020-2-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <1464887936-17020-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160610145745.GC7351@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Jun 2016, Hans de Goede wrote:

> The axp22x pmic has a bunch of volatile registers besides the interrupt
> ones, extend axp22x_volatile_ranges with these.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v2:
> -Added Chen-Yu's Acked-by
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index e4e3297..ca04361 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -93,7 +93,10 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
>  };
>  
>  static const struct regmap_range axp22x_volatile_ranges[] = {
> +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
> +	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
>  };
>  
>  static const struct regmap_access_table axp22x_writeable_table = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
