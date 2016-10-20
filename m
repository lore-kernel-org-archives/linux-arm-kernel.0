From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 22:10:03 +0800
Subject: [PATCH 5/8] ARM: gr8: Add missing pwm channel 1 pin
In-Reply-To: <0df42247c3348e7f6aed945e5669cec87f96f7ac.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
 <0df42247c3348e7f6aed945e5669cec87f96f7ac.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66w0sTzn_SWH4rrpWKOosSxALV8ot3CBQbGhwLxvX1vxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 4:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The PWM controller has two different channels, but only the first pin was
> exposed in the DTSI. Add the other one.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  arch/arm/boot/dts/ntc-gr8.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> index 74aff795e723..fad7381630f3 100644
> --- a/arch/arm/boot/dts/ntc-gr8.dtsi
> +++ b/arch/arm/boot/dts/ntc-gr8.dtsi
> @@ -854,6 +854,13 @@
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
>
> +                       pwm1_pins_a: pwm1 at 0 {

Nit: really don't need "_a" and "@0" here.

> +                               allwinner,pins = "PG13";
> +                               allwinner,function = "pwm1";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
>                         spdif_tx_pins_a: spdif at 0 {
>                                 allwinner,pins = "PB10";
>                                 allwinner,function = "spdif";
> --
> git-series 0.8.10
