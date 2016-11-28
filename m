From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 28 Nov 2016 18:06:33 +0800
Subject: [RFC PATCH] ARM: dts: sun8i: add simplefb node for H3
In-Reply-To: <20161128095900.27615-1-icenowy@aosc.xyz>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
Message-ID: <CAGb2v67akcT6z-xOdCzpLQRZbgNGh3E5akYEs1BvFNP1rH8UeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 5:59 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> As there's currently a fork of U-Boot which provides simplefb support

Please add it when its finalized...

> for H3, a simplefb node can be added to the device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>
> I'm still not sure which pipeline should I use.

You are supposed to add _all_ the pipelines that are available and
supported by U-boot. U-boot is then supposed to enable and update
the one it set up.

ChenYu

>
> And, it seems that HDMI Slow Clock is not needed?
>
> (seems that it's only for EDID, but simplefb won't use EDID)
>
>  arch/arm/boot/dts/sun8i-h3.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 75a8654..cacc8dd 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -50,6 +50,22 @@
>  / {
>         interrupt-parent = <&gic>;
>
> +       chosen {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               simplefb_hdmi: framebuffer at 0 {
> +                       compatible = "allwinner,simple-framebuffer",
> +                                    "simple-framebuffer";
> +                       allwinner,pipeline = "de0-lcd0-hdmi";
> +                       clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_BUS_DE>,
> +                                <&ccu CLK_BUS_HDMI>, <&ccu CLK_DE>,
> +                                <&ccu CLK_TCON0>, <&ccu CLK_HDMI>;
> +                       status = "disabled";
> +               };
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> --
> 2.10.2
>
