From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jun 2018 11:32:34 +0800
Subject: [linux-sunxi] [PATCH v2 6/7] arm64: allwinner: a64: add device
 tree node for HDMI simplefb
In-Reply-To: <20180622124540.56203-5-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
 <20180622124540.56203-5-icenowy@aosc.io>
Message-ID: <CAGb2v65W5zVGygcYx2CJDOm__Txp-Fjf=38axo=0K4A0g8hb_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 8:45 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As the U-Boot bootloader now is also capable of initialize the HDMI on
> A64 boards, add a simplefb device tree node for accessing the HDMI
> framebuffer initialized by the bootloader.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

The subject should have "dts" in it, like:

    arm64: dts: allwinner: a64: ....

Seems we've been missing them for half the patches this coming cycle.

ChenYu

> ---
> Changes in v2:
> - Dropped LCD SimpleFB as it's already added. LCD SimpleFB needs some
>   fix but the fix is present when adding DE2 CCU.
>
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 318c4ba8ae9f..840753432ea5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -68,6 +68,15 @@
>                                  <&display_clocks CLK_MIXER0>;
>                         status = "disabled";
>                 };
> +
> +               simplefb_hdmi: framebuffer-hdmi {
> +                       compatible = "allwinner,simple-framebuffer",
> +                                    "simple-framebuffer";
> +                       allwinner,pipeline = "mixer1-lcd1-hdmi";
> +                       clocks = <&display_clocks CLK_MIXER1>,
> +                                <&ccu CLK_TCON1>, <&ccu CLK_HDMI>;
> +                       status = "disabled";
> +               };
>         };
>
>         cpus {
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
