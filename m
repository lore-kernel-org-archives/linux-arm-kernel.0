From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 May 2016 19:14:15 +0800
Subject: [PATCH 3/3] mfd: axp20x: Add axp20x-usb-power-supply for axp22x
 pmics
In-Reply-To: <1463248289-16456-3-git-send-email-hdegoede@redhat.com>
References: <1463248289-16456-1-git-send-email-hdegoede@redhat.com>
 <1463248289-16456-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65cxMBgO7W2bHx1S+LbffHdh7VVaQA+sB4gws9Rt_Qj8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 15, 2016 at 1:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add axp20x-usb-power-supply for axp22x pmics.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ca04361..d62209d 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -160,6 +160,11 @@ static struct resource axp20x_usb_power_supply_resources[] = {
>         DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>  };
>
> +static struct resource axp22x_usb_power_supply_resources[] = {
> +       DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +       DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static struct resource axp22x_pek_resources[] = {
>         {
>                 .name   = "PEK_DBR",
> @@ -527,6 +532,11 @@ static struct mfd_cell axp22x_cells[] = {
>                 .resources              = axp22x_pek_resources,
>         }, {
>                 .name                   = "axp20x-regulator",
> +       }, {
> +               .name           = "axp20x-usb-power-supply",
> +               .of_compatible  = "x-powers,axp202-usb-power-supply",

As mentioned in the power supply patch, could you use a new compatible for the
axp22x variant? Thanks.

ChenYu

> +               .num_resources  = ARRAY_SIZE(axp22x_usb_power_supply_resources),
> +               .resources      = axp22x_usb_power_supply_resources,
>         },
>  };
>
> --
> 2.7.4
>
