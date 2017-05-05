From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:25:25 +0800
Subject: [linux-sunxi] [PATCH v6 12/13] ARM: dts: sun8i: add pinmux for
 LCD pins of V3s SoC
In-Reply-To: <20170504114858.9008-13-icenowy@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-13-icenowy@aosc.io>
Message-ID: <CAGb2v66jveLaAQ2wfd=LRwUy9zWjiycKqTyacFw=ZmuF8feOtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 7:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner V3s SoC features a set of pins that have functionality of RGB
> LCD, the pins are at different pin ban than other SoCs.
>
> Add pinctrl node for them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 0a895179d8ae..a37d68b227bc 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -297,6 +297,15 @@
>                                 function = "i2c0";
>                         };
>
> +                       lcd_rgb666_pins: lcd_rgb666 at 0 {

Drop the trailing "@0". Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +                               pins = "PE0", "PE1", "PE2", "PE3", "PE4",
> +                                      "PE5", "PE6", "PE7", "PE8", "PE9",
> +                                      "PE10", "PE11", "PE12", "PE13", "PE14",
> +                                      "PE15", "PE16", "PE17", "PE18", "PE19",
> +                                      "PE23", "PE24";
> +                               function = "lcd";
> +                       };
> +
>                         uart0_pins_a: uart0 at 0 {
>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
