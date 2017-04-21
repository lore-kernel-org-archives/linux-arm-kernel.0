From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 11:30:06 +0800
Subject: [PATCH 3/3] ARM: sun8i: a83t: Rename pinmux setting names
In-Reply-To: <20170418042205.27894-4-wens@csie.org>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-4-wens@csie.org>
Message-ID: <CAGb2v64s1vSVasHT_ABs9rKu-mWKi+uXZ74fvqkHDzp2kSkk=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:22 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> The pinmux setting nodes all have an address element in their node
> names, however the pinctrl node does not have #address-cells.
>
> Rename the existing pinmux setting nodes and labels in sun8i-a83t.dtsi,
> dropping identifiers for functions that only have one possible setting,
> and using the pingroup name if the function is identically available on
> different pingroups.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts |  2 +-
>  arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts       |  2 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi                      | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
[...]
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 82cb87f21b96..87b99338716b 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -174,7 +174,7 @@
>                         #interrupt-cells = <3>;
>                         #gpio-cells = <3>;
>
> -                       mmc0_pins_a: mmc0 at 0 {
> +                       mmc0_pins: mmc0_pins {
>                                 pins = "PF0", "PF1", "PF2",
>                                        "PF3", "PF4", "PF5";
>                                 function = "mmc0";
> @@ -182,13 +182,13 @@
>                                 bias-pull-up;
>                         };
>
> -                       uart0_pins_a: uart0 at 0 {
> -                               pins = "PF2", "PF4";
> +                       uart0_pb_pins: uart0_pb_pins {

Duh... Forgot to use hyphens instead of underscores in the node names.
I'll send a patch for you to squash in.

ChenYu

> +                               pins = "PB9", "PB10";
>                                 function = "uart0";
>                         };
>
> -                       uart0_pins_b: uart0 at 1 {
> -                               pins = "PB9", "PB10";
> +                       uart0_pf_pins: uart0_pf_pins {
> +                               pins = "PF2", "PF4";
>                                 function = "uart0";
>                         };
>                 };
> --
> 2.11.0
>
