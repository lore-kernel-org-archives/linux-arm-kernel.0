From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 23 Sep 2017 10:29:28 +0800
Subject: [PATCH v2 11/12] arm64: allwinner: a64: Fix node with unit name
 and no reg property
In-Reply-To: <20170922184045.6498-12-clabbe.montjoie@gmail.com>
References: <20170922184045.6498-1-clabbe.montjoie@gmail.com>
 <20170922184045.6498-12-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v67Gam27uNeNd1Ma-x=SgMNMN5OY1_juXLd63dXah+cNDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 2:40 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch fix the warning "xxx has a unit name, but no reg property" by
> removing "@0" from such node
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 662e8b7981b5..b02a8476b0c8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -347,7 +347,7 @@
>                                 function = "spi1";
>                         };
>
> -                       uart0_pins_a: uart0 at 0 {
> +                       uart0_pins_a: uart0 {

Same here. This should be uart0_pb_pins.

>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
>                         };
> @@ -571,7 +571,7 @@
>                         interrupt-controller;
>                         #interrupt-cells = <3>;
>
> -                       r_rsb_pins: rsb at 0 {
> +                       r_rsb_pins: rsb {

And this rsb_pins.

ChenYu

>                                 pins = "PL0", "PL1";
>                                 function = "s_rsb";
>                         };
> --
> 2.13.5
>
