From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Jan 2017 12:12:21 +0800
Subject: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs for
 AXP22X
In-Reply-To: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65Bwbi8JtOUydMoP4NFcDD_5VXUMzcWCP+S5UyKTA5H1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The AXP22X PMICs have multiple ADCs, each one exposing data from the
> different power supplies connected to the PMIC.
>
> This adds the different ADC data registers to the volatile registers of
> the AXP22X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
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
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>         regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +       regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),

You added this macro in the next patch. Please move that hunk to this patch.

ChenYu

>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>         regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> --
> 2.9.3
>
