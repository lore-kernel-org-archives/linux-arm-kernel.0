From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 23 Sep 2017 09:50:47 +0800
Subject: [PATCH v2 03/12] ARM: dts: sunxi: h3/h5: Fix node with unit name
 and no reg property
In-Reply-To: <20170922184045.6498-4-clabbe.montjoie@gmail.com>
References: <20170922184045.6498-1-clabbe.montjoie@gmail.com>
 <20170922184045.6498-4-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v66Sd7wCJGBLK1XANMbr=9DOZM34v1SEHFBGg6g_vknaZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 2:40 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch fix the warning "xxx has a unit name, but no reg property" by
> removing "@0" from such node.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 289f2cd06dfe..2e4bae988acd 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -322,7 +322,7 @@
>                                 function = "i2c2";
>                         };
>
> -                       mmc0_pins_a: mmc0 at 0 {
> +                       mmc0_pins_a: mmc0 {

All pinmux nodes should have the suffix "_pins" or "_pin".

In the case where there are multiple choices, the node name should convey
what or which pingroup the choice is. In this case the name should be
"mmc0_pf_pins".

>                                 pins = "PF0", "PF1", "PF2", "PF3",
>                                        "PF4", "PF5";
>                                 function = "mmc0";
> @@ -330,13 +330,13 @@
>                                 bias-pull-up;
>                         };
>
> -                       mmc0_cd_pin: mmc0_cd_pin at 0 {
> +                       mmc0_cd_pin: mmc0_cd_pin {
>                                 pins = "PF6";
>                                 function = "gpio_in";
>                                 bias-pull-up;
>                         };
>
> -                       mmc1_pins_a: mmc1 at 0 {
> +                       mmc1_pins_a: mmc1 {

mmc1_pins

>                                 pins = "PG0", "PG1", "PG2", "PG3",
>                                        "PG4", "PG5";
>                                 function = "mmc1";
> @@ -354,7 +354,7 @@
>                                 bias-pull-up;
>                         };
>
> -                       spdif_tx_pins_a: spdif at 0 {
> +                       spdif_tx_pins_a: spdif {

spdif_pin

>                                 pins = "PA17";
>                                 function = "spdif";
>                         };
> @@ -369,7 +369,7 @@
>                                 function = "spi1";
>                         };
>
> -                       uart0_pins_a: uart0 at 0 {
> +                       uart0_pins_a: uart0 {

uart0_pb_pins

>                                 pins = "PA4", "PA5";
>                                 function = "uart0";
>                         };
> @@ -697,7 +697,7 @@
>                         interrupt-controller;
>                         #interrupt-cells = <3>;
>
> -                       ir_pins_a: ir at 0 {
> +                       ir_pins_a: ir {

ir_pin

ChenYu

>                                 pins = "PL11";
>                                 function = "s_cir_rx";
>                         };
> --
> 2.13.5
>
