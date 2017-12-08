From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 8 Dec 2017 10:18:16 +0800
Subject: [PATCH v2 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <1512673460-7865-1-git-send-email-jagan@amarulasolutions.com>
References: <1512673460-7865-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v66EF8Szn81GiW_C_Jb1U4GSFqy2fP261S+de7jG2HQq7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 3:04 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - New patch
>
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 2 +-
>  drivers/regulator/axp20x-regulator.c             | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 9455503..34f24a2 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -43,7 +43,7 @@ Optional properties:
>                           regulator to drive the OTG VBus, rather then
>                           as an input pin which signals whether the
>                           board is driving OTG VBus or not.
> -                         (axp221 / axp223 / axp813 only)
> +                         (axp221 / axp223 / axp803/ axp813 only)

There is also a table of regulators in that file. Please update it.

ChenYu

>
>  - x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
>                         wired for master mode. The default is slave mode.
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 181622b..91b8ff8 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -721,6 +721,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>         case AXP803_ID:
>                 regulators = axp803_regulators;
>                 nregulators = AXP803_REG_ID_MAX;
> +               drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
> +                                                 "x-powers,drive-vbus-en");
>                 break;
>         case AXP806_ID:
>                 regulators = axp806_regulators;
> --
> 2.7.4
>
