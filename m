From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Mar 2016 14:59:41 +0800
Subject: [PATCH 1/2] regulator: axp20x: Fix axp22x ldo_io voltage ranges
In-Reply-To: <1457727151-16392-1-git-send-email-hdegoede@redhat.com>
References: <1457727151-16392-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67vsbH1-Vq_G_C=t3CCBFBaS1RCZc4ggqhoyjj7F_Hgaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2016 at 4:12 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The minium voltage of 1800mV is a copy and paste error from the axp20x
> regulator info. The correct minimum voltage for the ldo_io regulators
> on the axp22x is 700mV.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Fixes: 1b82b4e4f954 ("regulator: axp20x: Add support for AXP22X regulators")

then

Acked-by: Chen-Yu Tsai <wens@csie.org>

Also, this bug has been in since v4.2. Should we mark it for stable?

Regards
ChenYu


> ---
>  drivers/regulator/axp20x-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 40cd894..0c0e7a3 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -215,10 +215,10 @@ static const struct regulator_desc axp22x_regulators[] = {
>                  AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
>         AXP_DESC(AXP22X, ELDO3, "eldo3", "eldoin", 700, 3300, 100,
>                  AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
> -       AXP_DESC_IO(AXP22X, LDO_IO0, "ldo_io0", "ips", 1800, 3300, 100,
> +       AXP_DESC_IO(AXP22X, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
>                     AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
>                     AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
> -       AXP_DESC_IO(AXP22X, LDO_IO1, "ldo_io1", "ips", 1800, 3300, 100,
> +       AXP_DESC_IO(AXP22X, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
>                     AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
>                     AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
>         AXP_DESC_FIXED(AXP22X, RTC_LDO, "rtc_ldo", "ips", 3000),
> --
> 2.7.2
>
