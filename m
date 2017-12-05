From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 17:24:47 +0800
Subject: [linux-sunxi] [PATCH v4 09/10] ARM: dtsi: axp81x: add GPIO DT node
In-Reply-To: <af90c57ebf97c8f5504a4b5b1dad3638bedadfef.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <af90c57ebf97c8f5504a4b5b1dad3638bedadfef.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65mOwNBdit=gKOq0=iv94FNuH__4yvCw4v0NHYiCKccBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 9:44 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds DT node for the GPIO/pinctrl part present in AXP813/AXP818.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp81x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index 73b761f..0ef959d 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -48,6 +48,12 @@
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
> +       axp_gpio: axp-gpio {
> +               compatible = "x-powers,axp813-gpio";
> +               gpio-controller;
> +               #gpio-cells = <2>;

What about interrupt-controller for directly referenced interrupts from
the GPIO pins?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +       };
> +
>         regulators {
>                 /* Default work frequency for buck regulators */
>                 x-powers,dcdc-freq = <3000>;
> --
> git-series 0.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
