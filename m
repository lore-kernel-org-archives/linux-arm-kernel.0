From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 8 Jan 2017 03:16:22 +0800
Subject: [linux-sunxi][PATCH 3/3] ARM: dts: sun6i: Add SPDIF to the Mele I7
In-Reply-To: <20161220104038.22532-4-codekipper@gmail.com>
References: <20161220104038.22532-1-codekipper@gmail.com>
 <20161220104038.22532-4-codekipper@gmail.com>
Message-ID: <CAGb2v66atehFNDu-G94_WoFXzCPfZev4xsGD8ghr7+_gx-PZJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 6:40 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Enable the S/PDIF transmitter that is present on the Mele I7.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

This patch should be ready to be merged. The associated clk
and dtsi changes are already in Maxime's tree.

> ---
>  arch/arm/boot/dts/sun6i-a31-i7.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
> index a2193309a199..2bc57d2dcd80 100644
> --- a/arch/arm/boot/dts/sun6i-a31-i7.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
> @@ -69,6 +69,23 @@
>                         gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
>                 };
>         };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "On-board SPDIF";
> +               simple-audio-card,cpu {
> +                       sound-dai = <&spdif>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&spdif_out>;
> +               };
> +       };
> +
> +       spdif_out: spdif-out {
> +               #sound-dai-cells = <0>;
> +               compatible = "linux,spdif-dit";
> +       };
>  };
>
>  &codec {
> @@ -138,6 +155,13 @@
>         status = "okay";
>  };
>
> +&spdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spdif_pins_a>;
> +       spdif-out = "okay";
> +       status = "okay";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
