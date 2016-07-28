From: julian.calaby@gmail.com (Julian Calaby)
Date: Thu, 28 Jul 2016 20:24:41 +1000
Subject: [linux-sunxi] [PATCH] regulator: axp20x: support AXP813 variant
In-Reply-To: <5799d673.58a51c0a.97cf9.b9c0SMTPIN_ADDED_MISSING@gmr-mx.google.com>
References: <5799d673.58a51c0a.97cf9.b9c0SMTPIN_ADDED_MISSING@gmr-mx.google.com>
Message-ID: <CAGRGNgUeORYesjLAeaO=GGhC1rv9FUU5ZUdjRx8+Pz=vCggsEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Thu, Jul 28, 2016 at 5:28 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> The X-Powers AXP813 PMIC is close enough to the AXP809 with some
> more outputs.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 32 ++++++++-
>  drivers/mfd/axp20x-rsb.c                         |  1 +
>  drivers/mfd/axp20x.c                             |  3 +
>  drivers/regulator/axp20x-regulator.c             | 82 +++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h                       | 38 +++++++++++
>  5 files changed, 153 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 6d9ac76..c3287c9 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -467,7 +543,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>                  * name.
>                  */
>                 if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
> -                   (regulators == axp809_regulators && i == AXP809_DC1SW)) {
> +                   (regulators == axp809_regulators && i == AXP809_DC1SW) ||
> +                   (regulators == axp813_regulators && i == AXP813_DC1SW)) {

Are we getting to the point now where we need some other way to flag
these? Maybe a set of flags per regulator?

>                         new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
>                                                 GFP_KERNEL);
>                         *new_desc = regulators[i];
> @@ -505,7 +582,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>                  * Save AXP22X DCDC1 / DCDC5 regulator names for later.
>                  */
>                 if ((regulators == axp22x_regulators && i == AXP22X_DCDC1) ||
> -                   (regulators == axp809_regulators && i == AXP809_DCDC1))
> +                   (regulators == axp809_regulators && i == AXP809_DCDC1) ||
> +                   (regulators == axp813_regulators && i == AXP813_DCDC1))

Ditto.

>                         of_property_read_string(rdev->dev.of_node,
>                                                 "regulator-name",
>                                                 &dcdc1_name);

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
